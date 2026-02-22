import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:civis_web/data/repository/video_repository.dart';
import 'package:civis_web/data/model/video_lesson.dart';

part 'learning_view_model.g.dart';

@riverpod
class LearningViewModel extends _$LearningViewModel {
  @override
  List<VideoLesson> build() {
    final repository = ref.watch(videoRepositoryProvider);
    return repository.getVideos();
  }
}
