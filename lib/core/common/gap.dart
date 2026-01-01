import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  double? height;
  double? width;
  Gap({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
