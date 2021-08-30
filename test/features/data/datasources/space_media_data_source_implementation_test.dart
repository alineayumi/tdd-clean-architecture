import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/core/http_client/http_client.dart';
import 'package:tdd_clean_architecture/core/use_case/errors/exceptions.dart';
import 'package:tdd_clean_architecture/features/data/datasources/space_media_data_source.dart';
import 'package:tdd_clean_architecture/features/data/datasources/nasa_data_source_implementation.dart';
import 'package:tdd_clean_architecture/features/data/models/space_media_model.dart';
import '../../mocks/date_mock.dart';
import '../../mocks/space_media_mock.dart';

class HttpClientMocking extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDataSource dataSource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMocking();
    dataSource = NasaDataSourceImplementation(client);
  });

  final expectedUrl =
      'https://api.nasa.gov/planetary/apod?hd=true&api_key=DEMO_KEY&date=2021-08-27';

  void successfulMock() {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
  }

  test('should call the get method with proper url', () async {
    // Arrange
    successfulMock();
    // Act
    await dataSource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => client.get(expectedUrl)).called(1);
  });

  test('should return a SpaceMediaModel when is successful', () async {
    // Arrange
    successfulMock();
    final tExpectedSpaceMediaModel = SpaceMediaModel(
        description:
            'Like an illustration in a galactic Just So Story, the Elephant\'s Trunk Nebula winds through the emission nebula and young star cluster complex IC 1396, in the high and far off constellation of Cepheus. Also known as vdB 142, seen on the left the cosmic elephant\'s trunk is over 20 light-years long. Removed by digital processing, no visible stars are in this detailed telescopic close-up view highlighting the bright swept-back ridges that outline pockets of cool interstellar dust and gas. But the dark, tendril-shaped clouds contain the raw material for star formation and hide protostars within. Nearly 3,000 light-years distant, the relatively faint IC 1396 comple',
        mediaType: 'image',
        mediaUrl:
            'https://apod.nasa.gov/apod/image/2108/ElephantTrunkCaravan1024.jpg',
        title: 'Elephant\'s Trunk and Caravan');
    // Act
    final result = await dataSource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(result, tExpectedSpaceMediaModel);
  });

  test('should throw an exception when fails', () async {
    // Arrange
    when(() => client.get(any())).thenAnswer((_) async =>
        HttpResponse(data: 'something went wrong', statusCode: 400));
    // Act
    final result = dataSource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(() => result, throwsA(ServerException()));
  });
}
