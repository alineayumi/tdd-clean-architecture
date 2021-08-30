import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;

  CustomShimmer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Padding(
        child: child,
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      baseColor: Colors.grey,
      highlightColor: Colors.white,
    );
  }
}
