import 'package:flutter/widgets.dart';
import 'package:mechine_test_nasih/core/network/api_client.dart';
import 'package:mechine_test_nasih/core/network/app_urls.dart';
import 'package:mechine_test_nasih/features/auth/data/model/userdata_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserdataModel> login(String mobileNumber, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient apiClient;
  AuthRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<UserdataModel> login(String mobileNumber, String password) async {
    try {
      final payload = {'mobile': mobileNumber, 'password': password};
      final response = await apiClient.dio.post(
        AppUrls.loginUrl,
        data: payload,
      );
      if (response.statusCode == 201 && response.data['accessToken'] != null) {
        return UserdataModel.fromJson(response.data);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
