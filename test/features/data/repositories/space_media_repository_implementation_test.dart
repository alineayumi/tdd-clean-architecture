import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/exceptions.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/failures.dart';
import 'package:tdd_clean_architecture/features/data/datasources/space_media_data_source.dart';
import 'package:tdd_clean_architecture/features/data/models/space_media_model.dart';
import 'package:tdd_clean_architecture/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDataSource extends Mock implements ISpaceMediaDataSource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDataSource dataSource;

  setUp(() {
    dataSource = MockSpaceMediaDataSource();
    repository = SpaceMediaRepositoryImplementation(dataSource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    description:
        'Like an illustration in a galactic Just So Story, the Elephant\'s Trunk Nebula winds through the emission nebula and young star cluster complex IC 1396, in the high and far off constellation of Cepheus. Also known as vdB 142, seen on the left the cosmic elephant\'s trunk is over 20 light-years long. Removed by digital processing, no visible stars are in this detailed telescopic close-up view highlighting the bright swept-back ridges that outline pockets of cool interstellar dust and gas. But the dark, tendril-shaped clouds contain the raw material for star formation and hide protostars within. Nearly 3,000 light-years distant, the relatively faint IC 1396 comple',
    title: 'Elephant\'s Trunk and Caravan',
    mediaUrl:
        'https://apod.nasa.gov/apod/image/2108/ElephantTrunkCaravan1024.jpg',
    mediaType: 'image',
  );

  final date = DateTime.now();

  test('should return space media model when calls the datasource', () async {
    // Arrange
    when(() => dataSource.getSpaceMediaFromDate(date))
        .thenAnswer((_) async => tSpaceMediaModel);
    // Act
    final result = await repository.getSpaceFromMediaFromDate(date);
    // Assert
    expect(result, Right(tSpaceMediaModel));
    verify(() => dataSource.getSpaceMediaFromDate(date)).called(1);
  });

  test(
      'should return server failure when the call to the datasource is unsuccessful',
      () async {
    // Arrange
    when(() => dataSource.getSpaceMediaFromDate(date))
        .thenThrow(ServerException());
    // Act
    final result = await repository.getSpaceFromMediaFromDate(date);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => dataSource.getSpaceMediaFromDate(date)).called(1);
  });
}
