import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/failures.dart';
import 'package:tdd_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:tdd_clean_architecture/features/domain/repositories/space_media_repository.dart';
import 'package:tdd_clean_architecture/features/domain/use_cases/get_space_media_from_date_use_case.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUseCase useCase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    useCase = GetSpaceMediaFromDateUseCase(repository: repository);
  });

  final tSpaceMedia = SpaceMediaEntity(
    description:
        'Like an illustration in a galactic Just So Story, the Elephant\'s Trunk Nebula winds through the emission nebula and young star cluster complex IC 1396, in the high and far off constellation of Cepheus. Also known as vdB 142, seen on the left the cosmic elephant\'s trunk is over 20 light-years long. Removed by digital processing, no visible stars are in this detailed telescopic close-up view highlighting the bright swept-back ridges that outline pockets of cool interstellar dust and gas. But the dark, tendril-shaped clouds contain the raw material for star formation and hide protostars within. Nearly 3,000 light-years distant, the relatively faint IC 1396 comple',
    mediaType: 'image',
    title: 'Elephant\'s Trunk and Caravan',
    mediaUrl:
        'https://apod.nasa.gov/apod/image/2108/ElephantTrunkCaravan1024.jpg',
  );
  final DateTime date = DateTime.now();

  test('should get space media entity for a given date from the repository',
      () async {
    when(() => repository.getSpaceFromMediaFromDate(any()))
        .thenAnswer((_) async => Right(tSpaceMedia));

    final result = await useCase.call(date);
    expect(result, Right(tSpaceMedia));
    verifyNever(
        () => repository.getSpaceFromMediaFromDate(DateTime(2020, 08, 17)));
    verify(() => repository.getSpaceFromMediaFromDate(date)).called(1);
  });

  test('should return a ServerFailure if doesn\'t succeed', () async {
    when(() => repository.getSpaceFromMediaFromDate(any()))
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await useCase(date);

    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceFromMediaFromDate(date)).called(1);
  });
}
