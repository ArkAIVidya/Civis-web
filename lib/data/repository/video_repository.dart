import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/video_lesson.dart';

part 'video_repository.g.dart';

@riverpod
VideoRepository videoRepository(Ref ref) {
  return VideoRepository();
}

class VideoRepository {
  List<VideoLesson> getVideos() {
    return [
      const VideoLesson(
        id: "R7D0F6z_z7k",
        title: "US Civics Test Study Guide - US Constitution",
        description: "US Civics Test Study Guide - US Constitution",
        videoId: "E8FMI-Eu46o",
        thumbnailUrl: "https://img.youtube.com/vi/E8FMI-Eu46o/mqdefault.jpg",
      ),
      const VideoLesson(
        id: "F0O5v8eD_3Y",
        title: "US Civics Test Study Guide - Congress A Tale of Two Houses",
        description:
            "US Civics Test Study Guide - Congress A Tale of Two Houses",
        videoId: "Ub36ejfKQFE",
        thumbnailUrl: "https://img.youtube.com/vi/Ub36ejfKQFE/mqdefault.jpg",
      ),
      const VideoLesson(
        id: "kR9-W6s6n6I",
        title:
            "USCIS Civics Test Study Guide - The U S Executive Branch The American CEO",
        description:
            "USCIS Civics Test Study Guide - The U S Executive Branch The American CEO",
        videoId: "X1Sl_d6ofAA",
        thumbnailUrl: "https://img.youtube.com/vi/X1Sl_d6ofAA/mqdefault.jpg",
      ),
      const VideoLesson(
        id: "f-B6q8S0v_U",
        title: "USCIS Civics Test Study Guide - The U S Judicial Branch",
        description: "USCIS Civics Test Study Guide - The U S Judicial Branch",
        videoId: "I7Xlr9NYM9E",
        thumbnailUrl: "https://img.youtube.com/vi/I7Xlr9NYM9E/mqdefault.jpg",
      ),
      const VideoLesson(
        id: "vV1pC1mX7_Q",
        title: "USCIS Civics Test Study Guide - The American Revolution",
        description: "USCIS Civics Test Study Guide - The American Revolution",
        videoId: "cF8IvDDuWlU",
        thumbnailUrl: "https://img.youtube.com/vi/cF8IvDDuWlU/mqdefault.jpg",
      ),
      const VideoLesson(
        id: "8mGf7S8I0vY",
        title: "USCIS Civics Test Study Guide - The Birth of a Nation",
        description: "USCIS Civics Test Study Guide - The Birth of a Nation",
        videoId: "uc6vtFABxT0",
        thumbnailUrl: "https://img.youtube.com/vi/uc6vtFABxT0/mqdefault.jpg",
      ),
      const VideoLesson(
        id: "vV1pC1mX7_Q_dup", // Avoiding duplicate ID just in case
        title: "USCIS Civics Test Study Guide - The American Revolution",
        description: "USCIS Civics Test Study Guide - The American Revolution",
        videoId: "cF8IvDDuWlU",
        thumbnailUrl: "https://img.youtube.com/vi/cF8IvDDuWlU/mqdefault.jpg",
      ),
      const VideoLesson(
        id: "7hR8-H6k-2Q",
        title: "USCIS Civics Test Study Guide - Rights & Responsibilities",
        description:
            "USCIS Civics Test Study Guide - Rights & Responsibilities",
        videoId: "JsTujLfAab8",
        thumbnailUrl: "https://img.youtube.com/vi/JsTujLfAab8/mqdefault.jpg",
      ),
      const VideoLesson(
        id: "9_N6_X7Y0y4",
        title: "USCIS Civics Test Study Guide - The Civil War Test",
        description: "USCIS Civics Test Study Guide - The Civil War Test",
        videoId: "VLDnwc7Sy1Q",
        thumbnailUrl: "https://img.youtube.com/vi/VLDnwc7Sy1Q/mqdefault.jpg",
      ),
      const VideoLesson(
        id: "3u_xP9R-v6U",
        title: "USCIS Civics Test Study Guide - Symbols and Holidays",
        description: "USCIS Civics Test Study Guide - Symbols and Holidays",
        videoId: "cz7zyY21lTc",
        thumbnailUrl: "https://img.youtube.com/vi/cz7zyY21lTc/mqdefault.jpg",
      ),
      const VideoLesson(
        id: "wX-yU4vDk8E",
        title:
            "USCIS Civics Test Study Guide - American History 1900–2001 The American Century",
        description:
            "USCIS Civics Test Study Guide - American History 1900–2001 The American Century",
        videoId: "YjC1qg6pwkw",
        thumbnailUrl: "https://img.youtube.com/vi/YjC1qg6pwkw/mqdefault.jpg",
      ),
    ];
  }
}
