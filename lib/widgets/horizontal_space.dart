import 'package:flutter/material.dart';

// A nice helper widget I found useful from my time at Betterment
class HorizontalSpace extends StatelessWidget {
  final double horizontalSpaceBaseSize = 8.0;
  final int byFactorOf;

  const HorizontalSpace({Key? key, this.byFactorOf = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontalSpaceBaseSize * byFactorOf,
    );
  }
}
