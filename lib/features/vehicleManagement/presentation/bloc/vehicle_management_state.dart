part of 'vehicle_management_bloc.dart';

class VehicleManagementState {
  final bool? isLoading;
  final List<VehicleEntity> vehicles;
  final String? errorMessage;
  final CrudStatus status;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int skip;

  VehicleManagementState({
    this.isLoading,
    this.errorMessage,
    this.status = CrudStatus.idle,
    required this.vehicles,
    required this.hasReachedMax,
    required this.isLoadingMore,
    required this.skip,
  });

  factory VehicleManagementState.initial() {
    return VehicleManagementState(
      isLoading: true,
      status: CrudStatus.idle,
      vehicles: [],
      errorMessage: null,
      hasReachedMax: false,
      isLoadingMore: false,
      skip: 0,
    );
  }

  VehicleManagementState copyWith({
    bool? isLoading,
    List<VehicleEntity>? vehicles,
    CrudStatus? status,
    String? errorMessage,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? skip,
  }) {
    return VehicleManagementState(
      isLoading: isLoading ?? this.isLoading,
      vehicles: vehicles ?? this.vehicles,
      status: status ?? this.status,
      errorMessage: errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      skip: skip ?? this.skip,
    );
  }
}
