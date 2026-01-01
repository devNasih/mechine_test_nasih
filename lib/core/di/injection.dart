import 'package:get_it/get_it.dart';
import 'package:mechine_test_nasih/core/network/api_client.dart';
import 'package:mechine_test_nasih/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:mechine_test_nasih/features/auth/data/repository/auth_repo_impl.dart';
import 'package:mechine_test_nasih/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:mechine_test_nasih/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(apiClient: sl.get<ApiClient>()),
  );
  sl.registerLazySingleton<AuthRepoImpl>(
    () => AuthRepoImpl(remoteDatasource: sl.get<AuthRemoteDatasource>()),
  );
  sl.registerLazySingleton<UserLoginUsecase>(
    () => UserLoginUsecase(authRepository: sl.get<AuthRepoImpl>()),
  );
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(userLoginUsecase: sl.get<UserLoginUsecase>()),
  );
}
