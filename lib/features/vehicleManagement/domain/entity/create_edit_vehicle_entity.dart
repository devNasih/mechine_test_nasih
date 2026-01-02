class CreateUpdateVehicleEntity {
  String? id;
  String? name;
  String? model;
  String? color;
  String? registrationNumber;

  CreateUpdateVehicleEntity({
    this.id,
    this.name,
    this.model,
    this.color,
    this.registrationNumber,
  });
  CreateUpdateVehicleEntity copyWith({
    String? id,
    String? name,
    String? model,
    String? color,
    String? registrationNumber,
  }) {
    return CreateUpdateVehicleEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      model: model ?? this.model,
      color: color ?? this.color,
      registrationNumber: registrationNumber ?? this.registrationNumber,
    );
  }
}
