import 'package:mechine_test_nasih/core/network/api_client.dart';
import 'package:mechine_test_nasih/core/network/app_urls.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/data/model/create_edit_vehicle_model.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/data/model/vehicle_model.dart';

abstract class VehicleRemoteDatasource {
  Future<List<VehicleModel>> getVehicles(int limit,int skip);
  Future<VehicleModel> addVehicle(CreateUpdateVehicleModel vehicle);
  Future<VehicleModel> updateVehicle(CreateUpdateVehicleModel vehicle);
  Future<bool> deleteVehicle(String id);
}

class VehicleRemoteDatasourceImpl implements VehicleRemoteDatasource {
  final ApiClient apiClient;
  VehicleRemoteDatasourceImpl({required this.apiClient});

 @override
Future<List<VehicleModel>> getVehicles(int limit, int skip) async {
  try {
    final payload = {
      "limit": limit,
      "skip": skip,
    };
    final response = await apiClient.dio.post(
      AppUrls.vehicleListUrl,
      data: payload,
    );
    if (response.statusCode == 201 &&
        response.data['message'] == 'success') {
      final List list = response.data['data']['list'];
      return list
          .map((e) => VehicleModel.fromJson(e))
          .toList();
    } else {
      throw Exception(response.data['message']);
    }
  } catch (e) {
    rethrow;
  }
}


  @override
  Future<VehicleModel> addVehicle(CreateUpdateVehicleModel vehicle) async {
    try {
      final payload = vehicle.toMap();
      final response = await apiClient.dio.post(
        AppUrls.createVehicleUrl,
        data: payload,
      );
      if (response.statusCode == 201 && response.data['message'] == 'OK') {
        final data = response.data['data'];
        return VehicleModel.fromJson(data);
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VehicleModel> updateVehicle(CreateUpdateVehicleModel vehicle) async {
    try {
      final payload = vehicle.toMap();
      final response = await apiClient.dio.put(
        AppUrls.updateVehicleUrl,
        data: payload,
      );
      if (response.statusCode == 200 && response.data['message'] == 'success') {
        final data = response.data['data'];
        return VehicleModel.fromJson(data);
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteVehicle(String id) async {
    try {
      final payload = {"vehicleId": id};
      final response = await apiClient.dio.delete(
        AppUrls.deleteVehicleUrl,
        data: payload,
      );
      if (response.statusCode == 200 && response.data['message'] == 'success') {
        return true;
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
