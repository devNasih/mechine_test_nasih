import 'package:mechine_test_nasih/features/auth/domain/entity/userdata_entity.dart';

class UserdataModel extends UserdataEntity {
  String? accessToken;

  UserdataModel({
    this.accessToken,
    super.id,
    super.name,
    super.uid,
    super.otp,
    super.mobileNumber,
    super.otpExpiry,
    super.createdAt,
    super.checkInStatus,
    super.createdUserId,
    super.updatedAt,
    super.updatedUserId,
    super.status,
    super.v,
  });

  factory UserdataModel.fromJson(Map<String, dynamic> json) => UserdataModel(
        accessToken: json['accessToken'],
        id: json['_id'],
        name: json['_name'],
        uid: json['_uid'],
        otp: json['_otp'],
        mobileNumber: json['_mobileNumber'],
        otpExpiry: json['_otpExpiry'],
        createdAt: json['_createdAt'],
        checkInStatus: json['_checkInStatus'],
        createdUserId: json['_createdUserId'],
        updatedAt: json['_updatedAt'],
        updatedUserId: json['_updatedUserId'],
        status: json['_status'],
        v: json['__v'],
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        '_id': id,
        '_name': name,
        '_uid': uid,
        '_otp': otp,
        '_mobileNumber': mobileNumber,
        '_otpExpiry': otpExpiry,
        '_createdAt': createdAt,
        '_checkInStatus': checkInStatus,
        '_createdUserId': createdUserId,
        '_updatedAt': updatedAt,
        '_updatedUserId': updatedUserId,
        '_status': status,
        '__v': v,
      };
}