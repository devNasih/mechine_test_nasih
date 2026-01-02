import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechine_test_nasih/core/common/buttons.dart';
import 'package:mechine_test_nasih/core/common/snack_bar.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/data/model/enums/status.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/presentation/bloc/vehicle_management_bloc.dart';

class DeleteBottomSheet extends StatelessWidget {
  final String vehicleId;
  final String vehicleName;
  final VoidCallback? onDelete;

  const DeleteBottomSheet({
    super.key,
    required this.vehicleName,
    required this.vehicleId,
    this.onDelete,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String vehicleName,
    required String vehicleId,
    VoidCallback? onDelete,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: DeleteBottomSheet(
          vehicleName: vehicleName,
          vehicleId: vehicleId,
          onDelete: onDelete,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.red[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              size: 32,
              color: Colors.red[600],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'Delete Vehicle',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 12),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                height: 1.5,
              ),
              children: [
                const TextSpan(text: 'Are you sure you want to delete '),
                TextSpan(
                  text: '"$vehicleName"',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const TextSpan(text: '? This action cannot be undone.'),
              ],
            ),
          ),
          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  outlined: true,
                  text: 'Cancel',
                  textColor: Colors.grey[800],
                  onPressed: () => Navigator.pop(context, false),
                  height: 54,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[800],
                    side: BorderSide(color: Colors.grey[400]!),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              BlocConsumer<VehicleManagementBloc, VehicleManagementState>(
                listener: (context, state) {
                 if(state.status == CrudStatus.success) {
                    Navigator.pop(context, true);
                    CustomSnackBar.show(
                      context,
                      message: 'Vehicle deleted successfully',
                      isSuccess: true,
                    );
                    return;
                  }
                  if(state.status == CrudStatus.failure) {
                    CustomSnackBar.show(
                      context,
                      message: state.errorMessage ?? 'Failed to delete vehicle',
                      isSuccess: false,
                    );
                    return;
                  }

                },
                builder: (context, state) {
                  return Expanded(
                    child: ButtonWidget(
                      text: 'Delete',
                      onPressed: () {
                        onDelete?.call();
                      },
                      height: 54,
                      isLoading: state.status == CrudStatus.loading,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
        ],
      ),
    );
  }
}
