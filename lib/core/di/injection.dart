import 'package:get_it/get_it.dart';
import 'package:mechine_test_nasih/core/network/api_client.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
}
