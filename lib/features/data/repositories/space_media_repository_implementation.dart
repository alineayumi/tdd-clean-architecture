import 'package:dartz/dartz.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/exceptions.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/failures.dart';
import 'package:tdd_clean_architecture/features/data/datasources/space_media_data_source.dart';
import 'package:tdd_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:tdd_clean_architecture/features/domain/repositories/space_media_repository.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDataSource dataSource;

  SpaceMediaRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceFromMediaFromDate(
      DateTime date) async {
    try {
      final result = await dataSource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
