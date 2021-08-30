import 'package:flutter_triple/flutter_triple.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/failures.dart';
import 'package:tdd_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:tdd_clean_architecture/features/domain/use_cases/get_space_media_from_date_use_case.dart';

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUseCase useCase;

  HomeStore(this.useCase)
      : super(SpaceMediaEntity(
          description: '',
          mediaType: '',
          title: '',
          mediaUrl: '',
        ));

  getSpaceMediaFromDate(DateTime? date) async {
    setLoading(true);
    final result = await useCase(date);
    result.fold((error) => setError(error), (success) => update(success));
    setLoading(false);
  }
}
