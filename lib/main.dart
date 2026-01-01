import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechine_test_nasih/core/di/injection.dart';
import 'package:mechine_test_nasih/core/helpers/navigation_helper.dart';
import 'package:mechine_test_nasih/core/theme/color.dart';
import 'package:mechine_test_nasih/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mechine_test_nasih/features/auth/presentation/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl.get<AuthBloc>())],
      child: MaterialApp(
        title: 'Parking App',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.scafoldBackground),
        home: Login(),
      ),
    );
  }
}
