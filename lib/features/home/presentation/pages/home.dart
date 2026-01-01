import 'package:flutter/material.dart';
import 'package:mechine_test_nasih/core/common/scaffold.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(body: const Center(child: Text("Home")));
  }
}
