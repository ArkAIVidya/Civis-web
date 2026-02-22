import 'package:civis_web/data/model/video_lesson.dart';
import 'package:civis_web/data/repository/video_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late String _currentVideoId;

  @override
  void initState() {
    super.initState();
    _currentVideoId = widget.videoId;
    _initializeController();
  }

  void _initializeController() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: _currentVideoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant VideoPlayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videoId != oldWidget.videoId) {
      _loadVideo(widget.videoId);
    }
  }

  void _loadVideo(String videoId) {
    setState(() {
      _currentVideoId = videoId;
    });
    _controller.loadVideoById(videoId: videoId);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.read(videoRepositoryProvider);
    final videos = repository.getVideos();
    final currentIndex = videos.indexWhere((v) => v.videoId == _currentVideoId);
    final currentVideo = currentIndex != -1
        ? videos[currentIndex]
        : videos.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentVideo.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/landing');
            }
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            // Desktop/Wide Layout
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: YoutubePlayer(controller: _controller),
                      ),
                      _buildControls(currentIndex, videos),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          currentVideo.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(flex: 1, child: _buildPlaylist(videos)),
              ],
            );
          } else {
            // Mobile/Narrow Layout
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayer(controller: _controller),
                ),
                _buildControls(currentIndex, videos),
                Expanded(child: _buildPlaylist(videos)),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildControls(int currentIndex, List<VideoLesson> videos) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: currentIndex > 0
                ? () => _loadVideo(videos[currentIndex - 1].videoId)
                : null,
            icon: const Icon(Icons.skip_previous),
            label: const Text("Previous"),
          ),
          ElevatedButton.icon(
            onPressed: currentIndex < videos.length - 1
                ? () => _loadVideo(videos[currentIndex + 1].videoId)
                : null,
            icon: const Icon(Icons.skip_next),
            label: const Text("Next"),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylist(List<VideoLesson> videos) {
    return ListView.separated(
      itemCount: videos.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final video = videos[index];
        final isSelected = video.videoId == _currentVideoId;
        return ListTile(
          selected: isSelected,
          leading: Image.network(
            video.thumbnailUrl,
            width: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
          title: Text(
            video.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: isSelected
                ? const TextStyle(fontWeight: FontWeight.bold)
                : null,
          ),
          onTap: () => _loadVideo(video.videoId),
        );
      },
    );
  }
}
