// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'civics_data_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(civicsDataManager)
final civicsDataManagerProvider = CivicsDataManagerProvider._();

final class CivicsDataManagerProvider
    extends
        $FunctionalProvider<
          CivicsDataManager,
          CivicsDataManager,
          CivicsDataManager
        >
    with $Provider<CivicsDataManager> {
  CivicsDataManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'civicsDataManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$civicsDataManagerHash();

  @$internal
  @override
  $ProviderElement<CivicsDataManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CivicsDataManager create(Ref ref) {
    return civicsDataManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CivicsDataManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CivicsDataManager>(value),
    );
  }
}

String _$civicsDataManagerHash() => r'787fb0db298cc8a59a7ccf92f7f7ef00ae6f0a10';
