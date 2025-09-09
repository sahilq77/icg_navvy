// To parse this JSON data, do
//
//     final getUnitResponse = getUnitResponseFromJson(jsonString);

import 'dart:convert';

List<GetUnitResponse> getUnitResponseFromJson(String str) =>
    List<GetUnitResponse>.from(
      json.decode(str).map((x) => GetUnitResponse.fromJson(x)),
    );

String getUnitResponseToJson(List<GetUnitResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUnitResponse {
  String timestamp;
  String status;
  List<UnitData> data;
  String operationMode;
  List<ResponseInfo> responseInfo;

  GetUnitResponse({
    required this.timestamp,
    required this.status,
    required this.data,
    required this.operationMode,
    required this.responseInfo,
  });

  factory GetUnitResponse.fromJson(Map<String, dynamic> json) =>
      GetUnitResponse(
        timestamp: json["timestamp"],
        status: json["status"],
        data: List<UnitData>.from(
          json["data"].map((x) => UnitData.fromJson(x)),
        ),
        operationMode: json["operationMode"],
        responseInfo: List<ResponseInfo>.from(
          json["responseInfo"].map((x) => ResponseInfo.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "operationMode": operationMode,
    "responseInfo": List<dynamic>.from(responseInfo.map((x) => x.toJson())),
  };
}

class UnitData {
  List<Unit> unit;

  UnitData({required this.unit});

  factory UnitData.fromJson(Map<String, dynamic> json) => UnitData(
    unit: List<Unit>.from(json["unit"].map((x) => Unit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "unit": List<dynamic>.from(unit.map((x) => x.toJson())),
  };
}

class Unit {
  String unitCode;
  String unitName;

  Unit({required this.unitCode, required this.unitName});

  factory Unit.fromJson(Map<String, dynamic> json) =>
      Unit(unitCode: json["unitCode"], unitName: json["unitName"]);

  Map<String, dynamic> toJson() => {"unitCode": unitCode, "unitName": unitName};
}

class ResponseInfo {
  int msgCode;
  String msgType;
  String userMessage;

  ResponseInfo({
    required this.msgCode,
    required this.msgType,
    required this.userMessage,
  });

  factory ResponseInfo.fromJson(Map<String, dynamic> json) => ResponseInfo(
    msgCode: json["msgCode"],
    msgType: json["msgType"],
    userMessage: json["userMessage"],
  );

  Map<String, dynamic> toJson() => {
    "msgCode": msgCode,
    "msgType": msgType,
    "userMessage": userMessage,
  };
}
