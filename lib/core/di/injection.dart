import 'package:get_it/get_it.dart';
import 'package:mechine_test_nasih/core/network/api_client.dart';
import 'package:mechine_test_nasih/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:mechine_test_nasih/features/auth/data/repository/auth_repo_impl.dart';
import 'package:mechine_test_nasih/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:mechine_test_nasih/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/data/datasource/vehicle_remote_datasource.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/data/repository/vehicle_management_repo_impl.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/usecases/create_vehicle_usecase.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/usecases/delete_vehicle_usecase.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/usecases/update_vehicle_usecase.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/domain/usecases/get_vehicles_usecase.dart';
import 'package:mechine_test_nasih/features/vehicleManagement/presentation/bloc/vehicle_management_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(apiClient: sl.get<ApiClient>()),
  );
  sl.registerLazySingleton<VehicleRemoteDatasource>(
    () => VehicleRemoteDatasourceImpl(apiClient: sl.get<ApiClient>()),
  );
  sl.registerLazySingleton<VehicleManagementRepoImpl>(
    () => VehicleManagementRepoImpl(
      remoteDatasource: sl.get<VehicleRemoteDatasource>(),
    ),
  );
  sl.registerLazySingleton<AuthRepoImpl>(
    () => AuthRepoImpl(remoteDatasource: sl.get<AuthRemoteDatasource>()),
  );
  sl.registerLazySingleton<UserLoginUsecase>(
    () => UserLoginUsecase(authRepository: sl.get<AuthRepoImpl>()),
  );
  sl.registerLazySingleton<GetVehiclesUsecase>(
    () => GetVehiclesUsecase(
      vehicleManagementRepo: sl.get<VehicleManagementRepoImpl>(),
    ),
  );
  sl.registerLazySingleton<CreateVehicleUsecase>(
    () => CreateVehicleUsecase(
      vehicleManagementRepo: sl.get<VehicleManagementRepoImpl>(),
    ),
  );
  sl.registerLazySingleton<UpdateVehicleUsecase>(
    () => UpdateVehicleUsecase(
      vehicleManagementRepo: sl.get<VehicleManagementRepoImpl>(),
    ),
  );
  sl.registerLazySingleton<DeleteVehicleUsecase>(
    () => DeleteVehicleUsecase(
      vehicleManagementRepo: sl.get<VehicleManagementRepoImpl>(),
    ),
  );

  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(userLoginUsecase: sl.get<UserLoginUsecase>()),
  );
  sl.registerLazySingleton<VehicleManagementBloc>(
    () => VehicleManagementBloc(
      getVehiclesUsecase: sl.get<GetVehiclesUsecase>(),
      createVehicleUsecase: sl.get<CreateVehicleUsecase>(),
      updateVehicleUsecase: sl.get<UpdateVehicleUsecase>(),
      deleteVehicleUsecase: sl.get<DeleteVehicleUsecase>(),
    ),
  );
}
