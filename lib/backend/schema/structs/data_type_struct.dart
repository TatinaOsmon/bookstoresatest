// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataTypeStruct extends BaseStruct {
  DataTypeStruct({
    bool? paid,
    bool? success,
    int? revisedSum,
  })  : _paid = paid,
        _success = success,
        _revisedSum = revisedSum;

  // "paid" field.
  bool? _paid;
  bool get paid => _paid ?? false;
  set paid(bool? val) => _paid = val;
  bool hasPaid() => _paid != null;

  // "success" field.
  bool? _success;
  bool get success => _success ?? false;
  set success(bool? val) => _success = val;
  bool hasSuccess() => _success != null;

  // "revisedSum" field.
  int? _revisedSum;
  int get revisedSum => _revisedSum ?? 0;
  set revisedSum(int? val) => _revisedSum = val;
  void incrementRevisedSum(int amount) => _revisedSum = revisedSum + amount;
  bool hasRevisedSum() => _revisedSum != null;

  static DataTypeStruct fromMap(Map<String, dynamic> data) => DataTypeStruct(
        paid: data['paid'] as bool?,
        success: data['success'] as bool?,
        revisedSum: castToType<int>(data['revisedSum']),
      );

  static DataTypeStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? DataTypeStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'paid': _paid,
        'success': _success,
        'revisedSum': _revisedSum,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'paid': serializeParam(
          _paid,
          ParamType.bool,
        ),
        'success': serializeParam(
          _success,
          ParamType.bool,
        ),
        'revisedSum': serializeParam(
          _revisedSum,
          ParamType.int,
        ),
      }.withoutNulls;

  static DataTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataTypeStruct(
        paid: deserializeParam(
          data['paid'],
          ParamType.bool,
          false,
        ),
        success: deserializeParam(
          data['success'],
          ParamType.bool,
          false,
        ),
        revisedSum: deserializeParam(
          data['revisedSum'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'DataTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DataTypeStruct &&
        paid == other.paid &&
        success == other.success &&
        revisedSum == other.revisedSum;
  }

  @override
  int get hashCode => const ListEquality().hash([paid, success, revisedSum]);
}

DataTypeStruct createDataTypeStruct({
  bool? paid,
  bool? success,
  int? revisedSum,
}) =>
    DataTypeStruct(
      paid: paid,
      success: success,
      revisedSum: revisedSum,
    );
