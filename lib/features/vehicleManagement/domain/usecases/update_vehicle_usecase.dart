import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/create_edit_vehicle_entity.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/vehicle_enitity.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/repository/vehicle_management_repo.dart';

class UpdateVehicleUsecase {
  final VehicleManagementRepo vehicleManagementRepo;
  UpdateVehicleUsecase({required this.vehicleManagementRepo});
  Future<VehicleEntity> call(CreateUpdateVehicleEntity vehicle) async {
    return await vehicleManagementRepo.updateVehicle(vehicle);
  }
}
