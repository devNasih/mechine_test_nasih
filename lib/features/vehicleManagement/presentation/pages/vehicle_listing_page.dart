import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechine_test_nasih/core/common/buttons.dart';
import 'package:mechine_test_nasih/core/common/gap.dart';
import 'package:mechine_test_nasih/core/common/loader.dart';
import 'package:mechine_test_nasih/core/helpers/navigation_helper.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/presentation/bloc/vehicle_management_bloc.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/presentation/pages/add_edit_vehicle.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/presentation/widgets/delete_bottom_sheet.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/presentation/widgets/vehicle_card.dart';

class VehicleListingPage extends StatefulWidget {
  const VehicleListingPage({super.key});

  @override
  State<VehicleListingPage> createState() => _VehicleListingPageState();
}

class _VehicleListingPageState extends State<VehicleListingPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
        context.read<VehicleManagementBloc>().add(LoadVehiclesEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<VehicleManagementBloc>().add(LoadMoreCarsEvent());
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonWidget(
          text: 'Add New Vehicle',
          icon: Icons.add_circle_outline_rounded,
          onPressed: () => NavigationService.goTo(context, AddEditVehicle()),
          width: double.infinity,
          height: 54,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: Theme.of(context).primaryColor.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        Gap(height: 24),
        Expanded(child: _buildVehicleList()),
      ],
    );
  }

  Widget _buildVehicleList() {
    return BlocBuilder<VehicleManagementBloc, VehicleManagementState>(
      builder: (context, state) {
        if (state.isLoading ?? false) {
          return Loader();
        }
        if(state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }
        if(state.vehicles.isEmpty) {
          return const Center(child: Text('No vehicles found.'));
        }
        return ListView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount:
            state.vehicles.length + (state.isLoadingMore ? 1 : 0),
          padding: const EdgeInsets.only(bottom: 24),
          itemBuilder: (context, index) {


             if (index >= state.vehicles.length) {
            return  Padding(
              padding: EdgeInsets.all(16),
              child: Loader()
            );
          }
            final vehicleId = state.vehicles[index].id;
            final vehicleName = state.vehicles[index].name;
            return VehicleCard(
              vehicle: state.vehicles[index],
              onEdit: () => NavigationService.goTo(context, AddEditVehicle(isEdit: true, vehicle: state.vehicles[index])),
              onDelete:  () => DeleteBottomSheet.show(context, vehicleName: vehicleName ?? '', vehicleId: vehicleId ?? '', onDelete: () {
                context.read<VehicleManagementBloc>().add(DeleteVehicleEvent(vehicleId ?? ""));
              },
            ));
          },
        );
      },
    );
  }
}
