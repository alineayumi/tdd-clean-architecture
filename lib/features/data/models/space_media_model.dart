import 'package:tdd_clean_architecture/features/domain/entities/space_media_entity.dart';

class SpaceMediaModel extends SpaceMediaEntity {
  final String description;
  final String mediaType;
  final String title;
  final String mediaUrl;

  SpaceMediaModel({
    required this.description,
    required this.mediaType,
    required this.title,
    required this.mediaUrl,
  }) : super(
          description: description,
          mediaType: mediaType,
          title: title,
          mediaUrl: mediaUrl,
        );

  factory SpaceMediaModel.fromJson(Map<String, dynamic> json) =>
      SpaceMediaModel(
        description: json['explanation'],
        mediaType: json['media_type'],
        title: json['title'],
        mediaUrl: json['url'],
      );

  Map<String, dynamic> toJson() => {
        '': description,
        'media_type': mediaType,
        'title': title,
        'media_url': mediaUrl
      };
}
