import 'package:dartz/dartz.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/failures.dart';
import 'package:tdd_clean_architecture/core/use_case/use_case.dart';
import 'package:tdd_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:tdd_clean_architecture/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUseCase
    implements UseCase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUseCase({required this.repository});
  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceFromMediaFromDate(date);
  }
}
