import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tdd_clean_architecture/core/http_client/dio_implementation.dart';
import 'package:tdd_clean_architecture/core/utils/converters/date_converter.dart';
import 'package:tdd_clean_architecture/features/data/datasources/nasa_data_source_implementation.dart';
import 'package:tdd_clean_architecture/features/data/repositories/space_media_repository_implementation.dart';
import 'package:tdd_clean_architecture/features/domain/use_cases/get_space_media_from_date_use_case.dart';
import 'package:tdd_clean_architecture/features/presenter/controllers/home_store.dart';
import 'package:tdd_clean_architecture/features/presenter/pages/home_page.dart';
import 'package:tdd_clean_architecture/features/presenter/pages/picture_page.dart';

// app_module.dart
class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind((i) => HomeStore(i())),
    Bind((i) => GetSpaceMediaFromDateUseCase(repository: i())),
    Bind((i) => SpaceMediaRepositoryImplementation(i())),
    Bind((i) => NasaDataSourceImplementation(i())),
    Bind((i) => DioImplementation()),
    Bind((i) => DateToStringConverter()),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute(
      '/picture',
      child: (_, __) => PicturePage(),
    ),
  ];
}
