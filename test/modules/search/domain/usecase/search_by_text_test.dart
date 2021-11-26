import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();

  final useCase = SearchByTextImpl(repository: repository);

  test('deve retornar uma lista de result search', () async {
    when(repository.search('rodrigo'))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    final result = await useCase('rodrigo');
    expect(result?.getOrElse(() => []), isA<List<ResultSearch>>());
    return result;
  });

  test('deve retornar uma exception caso o texto seja invalido', () async {
    when(repository.search('rodrigo'))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    final result = await useCase('');
    expect(result?.isLeft, true);

    expect(result?.fold((l) => l, (r) => r), isA<InvalidTextError>());
    return result;
  });
}
