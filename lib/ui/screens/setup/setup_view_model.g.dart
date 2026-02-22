// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SetupViewModel)
final setupViewModelProvider = SetupViewModelProvider._();

final class SetupViewModelProvider
    extends $NotifierProvider<SetupViewModel, SetupUiState> {
  SetupViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setupViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setupViewModelHash();

  @$internal
  @override
  SetupViewModel create() => SetupViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetupUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetupUiState>(value),
    );
  }
}

String _$setupViewModelHash() => r'66504540cc1746ab7d29d44a13d69958fa708d47';

abstract class _$SetupViewModel extends $Notifier<SetupUiState> {
  SetupUiState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SetupUiState, SetupUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SetupUiState, SetupUiState>,
              SetupUiState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
