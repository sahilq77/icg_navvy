// To parse this JSON data, do
//
//     final getMedicalCategoryResponse = getMedicalCategoryResponseFromJson(jsonString);

import 'dart:convert';

List<GetMedicalCategoryResponse> getMedicalCategoryResponseFromJson(
  String str,
) => List<GetMedicalCategoryResponse>.from(
  json.decode(str).map((x) => GetMedicalCategoryResponse.fromJson(x)),
);

String getMedicalCategoryResponseToJson(
  List<GetMedicalCategoryResponse> data,
) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMedicalCategoryResponse {
  String timestamp;
  String status;
  List<Datum> data;
  String operationMode;
  List<ResponseInfo> responseInfo;

  GetMedicalCategoryResponse({
    required this.timestamp,
    required this.status,
    required this.data,
    required this.operationMode,
    required this.responseInfo,
  });

  factory GetMedicalCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetMedicalCategoryResponse(
        timestamp: json["timestamp"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  List<Medical> medical;

  Datum({required this.medical});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    medical: List<Medical>.from(
      json["medical"].map((x) => Medical.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "medical": List<dynamic>.from(medical.map((x) => x.toJson())),
  };
}

class Medical {
  String mediCode;
  String mediName;

  Medical({required this.mediCode, required this.mediName});

  factory Medical.fromJson(Map<String, dynamic> json) =>
      Medical(mediCode: json["mediCode"], mediName: json["mediName"]);

  Map<String, dynamic> toJson() => {"mediCode": mediCode, "mediName": mediName};
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
