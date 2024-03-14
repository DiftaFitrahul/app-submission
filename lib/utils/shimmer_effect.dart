import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobalShimmerEffect extends StatelessWidget {
  const GlobalShimmerEffect(
      {super.key,
      required this.height,
      required this.width,
      this.horizontalMargin = 12,
      this.verticalMargin = 8,
      this.borderRadius = 12});

  final double width;
  final double height;
  final double verticalMargin;
  final double horizontalMargin;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.15),
      highlightColor: Colors.grey.withOpacity(0.25),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: verticalMargin,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
