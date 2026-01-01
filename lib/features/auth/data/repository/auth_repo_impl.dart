import 'package:mechine_test_nasih/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:mechine_test_nasih/features/auth/domain/entity/userdata_entity.dart';
import 'package:mechine_test_nasih/features/auth/domain/repository/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepoImpl({required this.remoteDatasource});

  @override
  Future<UserdataEntity> login(String mobileNumber, String password) {
    return remoteDatasource.login(mobileNumber, password);
  }
}
