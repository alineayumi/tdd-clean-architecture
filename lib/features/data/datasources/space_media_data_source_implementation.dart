import 'dart:convert';
import 'package:tdd_clean_architecture/core/http_client/http_client.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/exceptions.dart';
import 'package:tdd_clean_architecture/core/utils/converters/date_converter.dart';
import 'package:tdd_clean_architecture/core/utils/keys/nasa_api.dart';
import 'package:tdd_clean_architecture/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:tdd_clean_architecture/features/data/datasources/space_media_data_source.dart';
import 'package:tdd_clean_architecture/features/data/models/space_media_model.dart';

class NasaDataSourceImplementation implements ISpaceMediaDataSource {
  final HttpClient client;

  NasaDataSourceImplementation(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(
        NasaApiKeys.apiKey, DateToStringConverter.convert(date)));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
