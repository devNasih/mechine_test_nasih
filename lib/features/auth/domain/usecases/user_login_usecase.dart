import 'package:mechine_test_nasih/features/auth/domain/entity/userdata_entity.dart';
import 'package:mechine_test_nasih/features/auth/domain/repository/auth_repository.dart';

class UserLoginUsecase {
  final AuthRepository authRepository;

  UserLoginUsecase({required this.authRepository});

  Future<UserdataEntity> call(String mobileNumber, String password) {
    return authRepository.login(mobileNumber, password);
  }
}
