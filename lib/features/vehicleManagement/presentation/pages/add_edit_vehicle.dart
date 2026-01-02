import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechine_test_nasih/core/common/app_bar.dart';
import 'package:mechine_test_nasih/core/common/buttons.dart';
import 'package:mechine_test_nasih/core/common/gap.dart';
import 'package:mechine_test_nasih/core/common/scaffold.dart';
import 'package:mechine_test_nasih/core/common/snack_bar.dart';
import 'package:mechine_test_nasih/core/common/textfield.dart';
import 'package:mechine_test_nasih/core/helpers/navigation_helper.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/data/model/enums/status.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/create_edit_vehicle_entity.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/vehicle_enitity.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/presentation/bloc/vehicle_management_bloc.dart';

class AddEditVehicle extends StatefulWidget {
  final bool isEdit;
  final VehicleEntity? vehicle;
  const AddEditVehicle({super.key, this.isEdit = false, this.vehicle});

  @override
  State<AddEditVehicle> createState() => _AddEditVehicleState();
}

class _AddEditVehicleState extends State<AddEditVehicle> {
  final formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _modelController = TextEditingController();

  final _colorController = TextEditingController();

  final _registrationNumberController = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit && widget.vehicle != null) {
      _nameController.text = widget.vehicle!.name ?? '';
      _modelController.text = widget.vehicle!.model ?? '';
      _colorController.text = widget.vehicle!.color ?? '';
      _registrationNumberController.text =
          widget.vehicle!.registrationNumber ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        widget.isEdit ? "Edit Vehicle" : "Add New Vehicle",
        context,
        needToShowLeading: true,
        leading: IconButton(
          onPressed: () => NavigationService.goBack(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: _buildForm(),
      bottomNavigationBar:
          BlocConsumer<VehicleManagementBloc, VehicleManagementState>(
            listener: (context, state) {
              if (state.status == CrudStatus.success) {
                NavigationService.goBack(context);
                CustomSnackBar.show(
                  context,
                  message: widget.isEdit
                      ? 'Vehicle updated successfully'
                      : 'Vehicle added successfully',
                  isSuccess: true,
                );
                return;
              }
              if (state.status == CrudStatus.failure) {
                CustomSnackBar.show(
                  context,
                  message: state.errorMessage ?? '',
                  isSuccess: false,
                );
                return;
              }
            },
            builder: (context, state) {
              return ButtonWidget(
                text: widget.isEdit ? 'Update Vehicle' : 'Add Vehicle',
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                icon: widget.isEdit
                    ? Icons.edit
                    : Icons.add_circle_outline_rounded,
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  final vehicleDetails = CreateUpdateVehicleEntity(
                    name: _nameController.text,
                    model: _modelController.text,
                    color: _colorController.text,
                    registrationNumber: _registrationNumberController.text,
                  );
                  if (widget.isEdit) {
                    context.read<VehicleManagementBloc>().add(
                      UpdateVehicleEvent(
                        vehicleDetails.copyWith(id: widget.vehicle?.id),
                      ),
                    );
                  } else {
                    context.read<VehicleManagementBloc>().add(
                      CreateVehicleEvent(vehicleDetails),
                    );
                  }
                },
                isLoading: state.status == CrudStatus.loading,
                width: double.infinity,
                height: 48,
              );
            },
          ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Gap(height: 14),
            CustomTextField(
              controller: _nameController,
              isLabelEnabled: true,
              isMandatory: true,
              label: 'Vehicle Name',
              hintText: "Enter Vehicle Name",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vehicle Name is required';
                }
                return null;
              },
            ),
            Gap(height: 15),
            CustomTextField(
              controller: _modelController,
              isLabelEnabled: true,
              isMandatory: true,
              label: 'Model',
              hintText: "Enter Model",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Model is required';
                }
                return null;
              },
            ),
      
            Gap(height: 15),
            CustomTextField(
              controller: _colorController,
              isLabelEnabled: true,
              isMandatory: true,
              label: 'Color',
              hintText: "What color is your vehicle?",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Color is required';
                }
                return null;
              },
            ),
            Gap(height: 15),
            CustomTextField(
              controller: _registrationNumberController,
              isLabelEnabled: true,
              isMandatory: true,
              label: 'Registration Number',
              hintText: "Enter Registration Number",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Registration Number is required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
