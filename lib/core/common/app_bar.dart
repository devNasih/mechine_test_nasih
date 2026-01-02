import 'package:flutter/material.dart';
import 'package:mechine_test_nasih/core/theme/color.dart';

PreferredSizeWidget customAppBar(
  String title,
  BuildContext context, {
  String? subtitle,
  String? subtitle2,
  PreferredSizeWidget? bottom,
  Color textColor = Colors.black,
  Color subtitleColor = Colors.black54,
  Color iconColor = Colors.black,
  bool needToShowLeading = false,
  VoidCallback? onBackPressed,
  bool centerTitle = true,
  bool showChatButton = false,
  List<Widget>? actions,
  Widget? leading,
  Color? bgColor,
  double? titleSize,
}) {
  return AppBar(
    backgroundColor: bgColor ?? AppColors.white,
    surfaceTintColor: Colors.transparent,
    automaticallyImplyLeading: false,
    leading: needToShowLeading ? leading : null,
    title: Column(
      crossAxisAlignment: centerTitle
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: titleSize,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(
              color: subtitleColor,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
        if (subtitle2 != null) ...[
          const SizedBox(height: 3),
          Text(
            subtitle2,
            style: TextStyle(
              color: subtitleColor,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    ),
    centerTitle: centerTitle,
    bottom: bottom,
    actions: actions,
  );
}
