// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(questionLoader)
final questionLoaderProvider = QuestionLoaderProvider._();

final class QuestionLoaderProvider
    extends $FunctionalProvider<QuestionLoader, QuestionLoader, QuestionLoader>
    with $Provider<QuestionLoader> {
  QuestionLoaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'questionLoaderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$questionLoaderHash();

  @$internal
  @override
  $ProviderElement<QuestionLoader> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  QuestionLoader create(Ref ref) {
    return questionLoader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuestionLoader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuestionLoader>(value),
    );
  }
}

String _$questionLoaderHash() => r'9d9cfa16e3d6011697f3a070b7e85440b6381767';

@ProviderFor(questionsRepository)
final questionsRepositoryProvider = QuestionsRepositoryProvider._();

final class QuestionsRepositoryProvider
    extends
        $FunctionalProvider<
          QuestionsRepository,
          QuestionsRepository,
          QuestionsRepository
        >
    with $Provider<QuestionsRepository> {
  QuestionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'questionsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$questionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<QuestionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  QuestionsRepository create(Ref ref) {
    return questionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuestionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuestionsRepository>(value),
    );
  }
}

String _$questionsRepositoryHash() =>
    r'ccecde00969b5d34ebe1e504a48792d7b1ba69cb';
