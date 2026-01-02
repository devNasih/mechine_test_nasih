class VehicleEntity {
  String? id;
  String? name;
  String? model;
  String? color;
  String? registrationNumber;
  int? createdAt;

  VehicleEntity({
    this.id,
    this.name,
    this.model,
    this.color,
    this.registrationNumber,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'color': color,
      'registrationNumber': registrationNumber,
      'createdAt': createdAt,
    };
  }
}
