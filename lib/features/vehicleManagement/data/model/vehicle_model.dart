import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/vehicle_enitity.dart';

class VehicleModel extends VehicleEntity {
  VehicleModel({
    super.id,
    super.name,
    super.model,
    super.color,
    super.registrationNumber,
    super.createdAt,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['_id'],
      name: json['_name'],
      model: json['_model'],
      color: json['_color'],
      registrationNumber: json['_number'],
      createdAt: json['_createdAt'],
    );
  }
}
