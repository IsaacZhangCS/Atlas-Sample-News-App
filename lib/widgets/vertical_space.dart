import 'package:flutter/material.dart';

// A nice helper widget I found useful from my time at Betterment
class VerticalSpace extends StatelessWidget {
  final int byFactorOf;

  const VerticalSpace({Key? key, this.byFactorOf = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.0 * byFactorOf,
    );
  }
}
