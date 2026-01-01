import 'package:mechine_test_nasih/features/auth/domain/entity/userdata_entity.dart';

abstract class AuthRepository {
  Future<UserdataEntity> login(String mobileNumber, String password);
}
