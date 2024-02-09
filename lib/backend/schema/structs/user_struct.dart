// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserStruct extends BaseStruct {
  UserStruct({
    int? userId,
    String? refreshToken,
    String? jwtToken,
  })  : _userId = userId,
        _refreshToken = refreshToken,
        _jwtToken = jwtToken;

  // "userId" field.
  int? _userId;
  int get userId => _userId ?? 0;
  set userId(int? val) => _userId = val;
  void incrementUserId(int amount) => _userId = userId + amount;
  bool hasUserId() => _userId != null;

  // "refreshToken" field.
  String? _refreshToken;
  String get refreshToken => _refreshToken ?? '';
  set refreshToken(String? val) => _refreshToken = val;
  bool hasRefreshToken() => _refreshToken != null;

  // "jwtToken" field.
  String? _jwtToken;
  String get jwtToken => _jwtToken ?? '';
  set jwtToken(String? val) => _jwtToken = val;
  bool hasJwtToken() => _jwtToken != null;

  static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
        userId: castToType<int>(data['userId']),
        refreshToken: data['refreshToken'] as String?,
        jwtToken: data['jwtToken'] as String?,
      );

  static UserStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? UserStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'userId': _userId,
        'refreshToken': _refreshToken,
        'jwtToken': _jwtToken,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userId': serializeParam(
          _userId,
          ParamType.int,
        ),
        'refreshToken': serializeParam(
          _refreshToken,
          ParamType.String,
        ),
        'jwtToken': serializeParam(
          _jwtToken,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserStruct(
        userId: deserializeParam(
          data['userId'],
          ParamType.int,
          false,
        ),
        refreshToken: deserializeParam(
          data['refreshToken'],
          ParamType.String,
          false,
        ),
        jwtToken: deserializeParam(
          data['jwtToken'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserStruct &&
        userId == other.userId &&
        refreshToken == other.refreshToken &&
        jwtToken == other.jwtToken;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([userId, refreshToken, jwtToken]);
}

UserStruct createUserStruct({
  int? userId,
  String? refreshToken,
  String? jwtToken,
}) =>
    UserStruct(
      userId: userId,
      refreshToken: refreshToken,
      jwtToken: jwtToken,
    );
