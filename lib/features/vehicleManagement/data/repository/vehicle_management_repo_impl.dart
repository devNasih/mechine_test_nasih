import 'package:mechine_test_nasih/features/vehicleManagement/data/datasource/vehicle_remote_datasource.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/data/model/create_edit_vehicle_model.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/create_edit_vehicle_entity.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/vehicle_enitity.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/repository/vehicle_management_repo.dart';

class VehicleManagementRepoImpl implements VehicleManagementRepo {
  final VehicleRemoteDatasource remoteDatasource;
  VehicleManagementRepoImpl({required this.remoteDatasource});

  @override
  Future<List<VehicleEntity>> getVehicles(int limit,int skip)async {
    return await remoteDatasource.getVehicles(limit, skip);
  }

  @override
  Future<VehicleEntity> addVehicle(CreateUpdateVehicleEntity vehicle)async {
    return await remoteDatasource.addVehicle(CreateUpdateVehicleModel.fromEntity(vehicle));
  }

  @override
  Future<VehicleEntity> updateVehicle(CreateUpdateVehicleEntity vehicle)async {
    return await remoteDatasource.updateVehicle(CreateUpdateVehicleModel.fromEntity(vehicle));
  }

  @override
  Future<bool> deleteVehicle(String id) async {
    return await remoteDatasource.deleteVehicle(id);
  }
}
