import 'package:bloc/bloc.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/data/model/enums/status.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/create_edit_vehicle_entity.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/entity/vehicle_enitity.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/usecases/create_vehicle_usecase.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/usecases/delete_vehicle_usecase.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/usecases/get_vehicles_usecase.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/usecases/update_vehicle_usecase.dart';
import 'package:meta/meta.dart';

part 'vehicle_management_event.dart';
part 'vehicle_management_state.dart';

class VehicleManagementBloc
    extends Bloc<VehicleManagementEvent, VehicleManagementState> {
  final int limit = 10;
  final GetVehiclesUsecase getVehiclesUsecase;
  final CreateVehicleUsecase createVehicleUsecase;
  final UpdateVehicleUsecase updateVehicleUsecase;
  final DeleteVehicleUsecase deleteVehicleUsecase;

  VehicleManagementBloc({
    required this.getVehiclesUsecase,
    required this.createVehicleUsecase,
    required this.updateVehicleUsecase,
    required this.deleteVehicleUsecase,
  }) : super(VehicleManagementState.initial()) {
    on<LoadVehiclesEvent>(_loadVehicles);
    on<LoadMoreCarsEvent>(_loadMoreVehicles);
    on<CreateVehicleEvent>(_createVehicle);
    on<UpdateVehicleEvent>(_updateVehicle);
    on<DeleteVehicleEvent>(_deleteVehicle);
  }
  Future<void> _loadVehicles(
      LoadVehiclesEvent event, Emitter<VehicleManagementState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final vehicles = await getVehiclesUsecase(limit, state.skip);
      emit(state.copyWith(
          isLoading: false, vehicles: vehicles, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.toString(), vehicles: []));
    }
  }
Future<void> _loadMoreVehicles(
  LoadMoreCarsEvent event,
  Emitter<VehicleManagementState> emit,
) async {
  if (state.isLoadingMore || state.hasReachedMax) return;

  emit(state.copyWith(isLoadingMore: true));

  try {
    final moreVehicles = await getVehiclesUsecase(
      limit,
      state.skip,
    );

    emit(state.copyWith(
      vehicles: [...state.vehicles, ...moreVehicles],
      isLoadingMore: false,
      skip: state.skip + moreVehicles.length,
      hasReachedMax: moreVehicles.length < limit,
    ));
  } catch (e) {
    emit(state.copyWith(
      isLoadingMore: false,
      errorMessage: e.toString(),
    ));
  }
}

  Future<void> _createVehicle(
      CreateVehicleEvent event, Emitter<VehicleManagementState> emit) async {
        emit(state.copyWith(status: CrudStatus.loading));
    try {
    final vehicle =await createVehicleUsecase(event.vehicle);
     emit(state.copyWith(
      vehicles: [vehicle, ...state.vehicles],
      skip: state.skip + 1,
      status: CrudStatus.success,
    ));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: CrudStatus.failure));
    }
  }
Future<void> _updateVehicle(
  UpdateVehicleEvent event,
  Emitter<VehicleManagementState> emit,
) async {
  emit(state.copyWith(
    status: CrudStatus.loading,
    errorMessage: null,
  ));
  try {
    final updatedVehicle =
        await updateVehicleUsecase(event.vehicle);
    emit(state.copyWith(
      vehicles: state.vehicles.map((vehicle) {
        return vehicle.id == updatedVehicle.id
            ? updatedVehicle
            : vehicle;
      }).toList(),
      status: CrudStatus.success,
    ));
  } catch (e) {
    emit(state.copyWith(
      status: CrudStatus.failure,
      errorMessage: e.toString(),
    ));
  }
}

  Future<void> _deleteVehicle(
      DeleteVehicleEvent event, Emitter<VehicleManagementState> emit) async {
    try {
      await deleteVehicleUsecase(event.vehicleId);
      final updatedVehicles = state.vehicles
          .where((vehicle) => vehicle.id != event.vehicleId)
          .toList();
      emit(state.copyWith(vehicles: updatedVehicles, skip: state.skip - 1));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
