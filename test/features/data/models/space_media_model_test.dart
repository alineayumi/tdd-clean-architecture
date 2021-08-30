import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture/features/data/models/space_media_model.dart';
import 'package:tdd_clean_architecture/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
    description:
        'Like an illustration in a galactic Just So Story, the Elephant\'s Trunk Nebula winds through the emission nebula and young star cluster complex IC 1396, in the high and far off constellation of Cepheus. Also known as vdB 142, seen on the left the cosmic elephant\'s trunk is over 20 light-years long. Removed by digital processing, no visible stars are in this detailed telescopic close-up view highlighting the bright swept-back ridges that outline pockets of cool interstellar dust and gas. But the dark, tendril-shaped clouds contain the raw material for star formation and hide protostars within. Nearly 3,000 light-years distant, the relatively faint IC 1396 comple',
    title: 'Elephant\'s Trunk and Caravan',
    mediaUrl:
        'https://apod.nasa.gov/apod/image/2108/ElephantTrunkCaravan1024.jpg',
    mediaType: 'image',
  );

  test('should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('should return a valid model', () {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);

    // Act
    final result = SpaceMediaModel.fromJson(jsonMap);

    // Assert
    expect(result, tSpaceMediaModel);
  });

  test('should return a json map containing the proper data', () {
    // Arrange
    final expectedMap = {
      "explanation":
          "Like an illustration in a galactic Just So Story, the Elephant's Trunk Nebula winds through the emission nebula and young star cluster complex IC 1396, in the high and far off constellation of Cepheus. Also known as vdB 142, seen on the left the cosmic elephant's trunk is over 20 light-years long. Removed by digital processing, no visible stars are in this detailed telescopic close-up view highlighting the bright swept-back ridges that outline pockets of cool interstellar dust and gas. But the dark, tendril-shaped clouds contain the raw material for star formation and hide protostars within. Nearly 3,000 light-years distant, the relatively faint IC 1396 comple",
      "media_type": "image",
      "title": "Elephant's Trunk and Caravan",
      "media_url":
          "https://apod.nasa.gov/apod/image/2108/ElephantTrunkCaravan1024.jpg"
    };

    // Act
    final result = tSpaceMediaModel.toJson();

    // Assert
    expect(result, expectedMap);
  });
}
