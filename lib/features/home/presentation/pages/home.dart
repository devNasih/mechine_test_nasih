import 'package:flutter/material.dart';
import 'package:mechine_test_nasih/core/common/app_bar.dart';
import 'package:mechine_test_nasih/core/common/scaffold.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/presentation/pages/vehicle_listing_page.dart';
import 'package:mechine_test_nasih/core/theme/color.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.scafoldBackground,
      bottomNavigationBar: SizedBox.shrink(),
      appBar: customAppBar(
        'Parking Management',
        context,
        bgColor: AppColors.scafoldBackground,
      ),
      body: VehicleListingPage(),
    );
  }
}
