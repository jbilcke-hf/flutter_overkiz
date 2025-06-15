import 'dart:convert';
import 'enums/general.dart';

/// Type definition for state values
typedef StateType = dynamic;

/// Type definition for JSON data
typedef JSON = Map<String, dynamic>;

/// Mapping from DataType to Dart conversion functions
const Map<DataType, dynamic Function(String)> dataTypeToDart = {
  DataType.integer: int.parse,
  DataType.date: int.parse,
  DataType.float: double.parse,
  DataType.boolean: _parseBool,
  DataType.jsonArray: jsonDecode,
  DataType.jsonObject: jsonDecode,
};

/// Parse string to boolean
bool _parseBool(String value) {
  return value.toLowerCase() == 'true';
}