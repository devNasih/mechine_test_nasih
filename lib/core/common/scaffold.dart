import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget? bottomNavigationBar;
  final bool isSafeAreaRemove;
  final bool isAppBarRemove;
  final bool extendBody;
  final bool showNoInternetPage;
  final bool? removeBottomSafeArea;

  const CommonScaffold({
    super.key,
    this.appBar,
    this.body,
    this.backgroundColor,
    this.padding,
    this.bottomNavigationBar,
    this.isSafeAreaRemove = false,
    this.isAppBarRemove = false,
    this.extendBody = false,
    this.showNoInternetPage = true,
    this.removeBottomSafeArea,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: body,
    );

    if (!isSafeAreaRemove) {
      content = SafeArea(bottom: removeBottomSafeArea ?? true, child: content);
    }

    return Scaffold(
      extendBody: extendBody,
      backgroundColor: backgroundColor,
      appBar: isAppBarRemove ? null : appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: content,
    );
  }
}
