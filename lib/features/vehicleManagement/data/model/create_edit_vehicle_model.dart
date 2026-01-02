import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/create_edit_vehicle_entity.dart';

class CreateUpdateVehicleModel extends CreateUpdateVehicleEntity {
  CreateUpdateVehicleModel({
    super.id,
    super.name,
    super.model,
    super.color,
    super.registrationNumber,
  });

  // toMap
Map<String, dynamic> toMap() {
  return {
    if (id != null) 'vehicleId': id,
    'name': name,
    'model': model,
    'color': color,
    'vehicleNumber': registrationNumber,
  };
}


  // formEntitiy
  factory CreateUpdateVehicleModel.fromEntity(
      CreateUpdateVehicleEntity entity) {
    return CreateUpdateVehicleModel(
      id: entity.id,
      name: entity.name,
      model: entity.model,
      color: entity.color,
      registrationNumber: entity.registrationNumber,
    );
  }
}
