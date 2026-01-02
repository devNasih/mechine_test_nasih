import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/create_edit_vehicle_entity.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/vehicle_enitity.dart';

abstract class VehicleManagementRepo {
  Future<List<VehicleEntity>> getVehicles( int limit,int skip);
  Future<VehicleEntity> addVehicle(CreateUpdateVehicleEntity vehicle);
  Future<VehicleEntity> updateVehicle(CreateUpdateVehicleEntity vehicle);
  Future<bool> deleteVehicle(String id);
}
