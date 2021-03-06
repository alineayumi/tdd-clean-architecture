import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tdd_clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:tdd_clean_architecture/features/presenter/controllers/home_store.dart';
import 'package:tdd_clean_architecture/features/presenter/widgets/custom_shimmer.dart';
import 'package:tdd_clean_architecture/features/presenter/widgets/description_bottom_sheet.dart';
import 'package:tdd_clean_architecture/features/presenter/widgets/image_network_with_loader.dart';

class PicturePage extends StatefulWidget {
  const PicturePage({Key? key}) : super(key: key);

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends ModularState<PicturePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return ScopedBuilder(
      store: store,
      onLoading: (context) => Center(child: CircularProgressIndicator()),
      onError: (context, error) => Center(
        child: Text(
          'An error occurred, try again later.',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      onState: (context, SpaceMediaEntity spaceMedia) => GestureDetector(
        onVerticalDragUpdate: (update) {
          if (update.delta.dy < 0) {
            showDescriptionBottomSheet(
              context: context,
              title: spaceMedia.title,
              description: spaceMedia.description,
            );
          }
        },
        onHorizontalDragUpdate: (update) {
          if (update.delta.dx > 0) {
            Modular.to.pushNamed('/');
          }
        },
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: spaceMedia.mediaType == 'video'
                  ? Center(child: Text('Video can\'t be displayed'))
                  : ImageNetworkWithLoader(url: spaceMedia.mediaUrl),
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: CustomShimmer(
                  child: Column(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: 35,
                      ),
                      Text(
                        'Slide up to see the description',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
