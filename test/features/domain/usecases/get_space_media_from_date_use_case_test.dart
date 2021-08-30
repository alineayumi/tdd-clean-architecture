import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/failures.dart';
import 'package:tdd_clean_architecture/features/domain/repositories/space_media_repository.dart';
import 'package:tdd_clean_architecture/features/domain/use_cases/get_space_media_from_date_use_case.dart';
import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUseCase useCase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    useCase = GetSpaceMediaFromDateUseCase(repository: repository);
  });

  test('should get space media entity for a given date from the repository',
      () async {
    when(() => repository.getSpaceFromMediaFromDate(any()))
        .thenAnswer((_) async => Right(tSpaceMedia));

    final result = await useCase.call(tDateTime);
    expect(result, Right(tSpaceMedia));
    verifyNever(
        () => repository.getSpaceFromMediaFromDate(DateTime(2020, 08, 17)));
    verify(() => repository.getSpaceFromMediaFromDate(tDateTime)).called(1);
  });

  test('should return a ServerFailure if doesn\'t succeed', () async {
    when(() => repository.getSpaceFromMediaFromDate(any()))
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await useCase(tDateTime);

    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceFromMediaFromDate(tDateTime)).called(1);
  });

  test('should return a NullParamFailure if receives a null param', () async {
    final result = await useCase(null);

    expect(result, Left(NullParamFailure()));
    verifyNever(() => repository.getSpaceFromMediaFromDate(any()));
  });
}
