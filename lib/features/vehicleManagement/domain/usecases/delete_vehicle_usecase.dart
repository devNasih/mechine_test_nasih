import 'package:mechine_test_nasih/features/vehicleManagement/domain/repository/vehicle_management_repo.dart';

class DeleteVehicleUsecase {
  final VehicleManagementRepo vehicleManagementRepo;
  DeleteVehicleUsecase({required this.vehicleManagementRepo});
  Future<bool> call(String id) async {
    return await vehicleManagementRepo.deleteVehicle(id);
  }
}
