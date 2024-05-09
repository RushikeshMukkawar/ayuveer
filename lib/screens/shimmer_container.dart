import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}
