import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/vehicle_enitity.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/repository/vehicle_management_repo.dart';

class GetVehiclesUsecase {
  final VehicleManagementRepo vehicleManagementRepo;
  GetVehiclesUsecase({required this.vehicleManagementRepo});
  Future<List<VehicleEntity>> call(int limit,int skip) async {
    return await vehicleManagementRepo.getVehicles(limit, skip);
  }
}
