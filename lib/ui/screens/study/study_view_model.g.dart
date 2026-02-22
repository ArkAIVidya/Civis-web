// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StudyViewModel)
final studyViewModelProvider = StudyViewModelProvider._();

final class StudyViewModelProvider
    extends $NotifierProvider<StudyViewModel, StudyUiState> {
  StudyViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studyViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studyViewModelHash();

  @$internal
  @override
  StudyViewModel create() => StudyViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StudyUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StudyUiState>(value),
    );
  }
}

String _$studyViewModelHash() => r'38864b4146d4144630297556287e8937c9c9b584';

abstract class _$StudyViewModel extends $Notifier<StudyUiState> {
  StudyUiState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<StudyUiState, StudyUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StudyUiState, StudyUiState>,
              StudyUiState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
