// To parse this JSON data, do
//
//     final getVerifyOtpResponse = getVerifyOtpResponseFromJson(jsonString);

import 'dart:convert';

List<GetVerifyOtpResponse> getVerifyOtpResponseFromJson(String str) =>
    List<GetVerifyOtpResponse>.from(
      json.decode(str).map((x) => GetVerifyOtpResponse.fromJson(x)),
    );

String getVerifyOtpResponseToJson(List<GetVerifyOtpResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetVerifyOtpResponse {
  String? timestamp;
  String? status;
  String? operationMode;
  List<ResponseInfo>? responseInfo;

  GetVerifyOtpResponse({
    this.timestamp,
    this.status,
    this.operationMode,
    this.responseInfo,
  });

  factory GetVerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      GetVerifyOtpResponse(
        timestamp: json["timestamp"],
        status: json["status"],
        operationMode: json["operationMode"],
        responseInfo: json["responseInfo"] == null
            ? null
            : List<ResponseInfo>.from(
                json["responseInfo"].map((x) => ResponseInfo.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp,
    "status": status,
    "operationMode": operationMode,
    "responseInfo": responseInfo == null
        ? null
        : List<dynamic>.from(responseInfo!.map((x) => x.toJson())),
  };
}

class ResponseInfo {
  int? msgCode;
  String? msgType;
  String? userMessage;

  ResponseInfo({this.msgCode, this.msgType, this.userMessage});

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
