import 'package:flutter/cupertino.dart';
import 'package:mechine_test_nasih/core/theme/color.dart';

class Loader extends StatelessWidget {
  Color? color;
  Loader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CupertinoActivityIndicator(color: color ?? AppColors.primary),
      ),
    );
  }
}
