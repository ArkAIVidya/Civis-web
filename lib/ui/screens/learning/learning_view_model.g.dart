// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LearningViewModel)
final learningViewModelProvider = LearningViewModelProvider._();

final class LearningViewModelProvider
    extends $NotifierProvider<LearningViewModel, List<VideoLesson>> {
  LearningViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningViewModelHash();

  @$internal
  @override
  LearningViewModel create() => LearningViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<VideoLesson> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<VideoLesson>>(value),
    );
  }
}

String _$learningViewModelHash() => r'29a932b74ffe2234a8786953afffc6cd2e872352';

abstract class _$LearningViewModel extends $Notifier<List<VideoLesson>> {
  List<VideoLesson> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<VideoLesson>, List<VideoLesson>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<VideoLesson>, List<VideoLesson>>,
              List<VideoLesson>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
