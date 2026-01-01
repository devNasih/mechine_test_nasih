import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'vehicle_management_event.dart';
part 'vehicle_management_state.dart';

class VehicleManagementBloc extends Bloc<VehicleManagementEvent, VehicleManagementState> {
  VehicleManagementBloc() : super(VehicleManagementInitial()) {
    on<VehicleManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
