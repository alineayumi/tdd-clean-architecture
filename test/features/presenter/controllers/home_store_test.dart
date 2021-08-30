import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/failures.dart';
import 'package:tdd_clean_architecture/features/domain/use_cases/get_space_media_from_date_use_case.dart';
import 'package:tdd_clean_architecture/features/presenter/controllers/home_store.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromUseCase extends Mock
    implements GetSpaceMediaFromDateUseCase {}

void main() {
  late HomeStore store;
  late GetSpaceMediaFromDateUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetSpaceMediaFromUseCase();
    store = HomeStore(mockUseCase);
  });

  test('should return a SpaceMedia from useCase', () async {
    // Arrange
    when(() => mockUseCase(any())).thenAnswer((_) async => Right(tSpaceMedia));
    // Act
    await store.getSpaceMediaFromDate(tDateTime);
    // Assert
    store.observer(onState: (state) {
      expect(state, tSpaceMedia);
      verify(() => mockUseCase(tDateTime)).called(1);
    });
  });

  final tFailure = ServerFailure();
  test('should return a Failure from userCase', () async {
    // Arrange
    when(() => mockUseCase(any())).thenAnswer((_) async => Left(tFailure));
    // Act
    await store.getSpaceMediaFromDate(tDateTime);
    // Assert
    store.observer(onError: (error) {
      expect(error, tFailure);
      verify(() => mockUseCase(tDateTime)).called(1);
    });
  });
}
