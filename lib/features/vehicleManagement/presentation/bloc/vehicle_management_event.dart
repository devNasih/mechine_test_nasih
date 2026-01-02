part of 'vehicle_management_bloc.dart';

@immutable
sealed class VehicleManagementEvent {}

class LoadVehiclesEvent extends VehicleManagementEvent {}

class LoadMoreCarsEvent extends VehicleManagementEvent {}

class CreateVehicleEvent extends VehicleManagementEvent {
  final CreateUpdateVehicleEntity vehicle;
  CreateVehicleEvent(this.vehicle);

  @override
  List<Object?> get props => [vehicle];
}

class UpdateVehicleEvent extends VehicleManagementEvent {
  final CreateUpdateVehicleEntity vehicle;
  UpdateVehicleEvent(this.vehicle);

  @override
  List<Object?> get props => [vehicle];
}

class DeleteVehicleEvent extends VehicleManagementEvent {
  final String vehicleId;
  DeleteVehicleEvent(this.vehicleId);

  @override
  List<Object?> get props => [vehicleId];
}