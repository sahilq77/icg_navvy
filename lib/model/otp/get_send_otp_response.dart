// To parse this JSON data, do
//
//     final getSendOtpResponse = getSendOtpResponseFromJson(jsonString);

import 'dart:convert';

List<GetSendOtpResponse> getSendOtpResponseFromJson(String str) =>
    List<GetSendOtpResponse>.from(
        json.decode(str).map((x) => GetSendOtpResponse.fromJson(x)));

String getSendOtpResponseToJson(List<GetSendOtpResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSendOtpResponse {
  String? timestamp; // Made nullable
  String? status; // Made nullable
  List<Datum>? data; // Made nullable
  String? operationMode; // Made nullable
  List<ResponseInfo>? responseInfo; // Made nullable

  GetSendOtpResponse({
    this.timestamp,
    this.status,
    this.data,
    this.operationMode,
    this.responseInfo,
  });

  factory GetSendOtpResponse.fromJson(Map<String, dynamic> json) =>
      GetSendOtpResponse(
        timestamp: json["timestamp"] as String?,
        status: json["status"] as String?,
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
        operationMode: json["operationMode"] as String?,
        responseInfo: json["responseInfo"] != null
            ? List<ResponseInfo>.from(
                json["responseInfo"].map((x) => ResponseInfo.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (timestamp != null) "timestamp": timestamp,
        if (status != null) "status": status,
        if (data != null)
          "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        if (operationMode != null) "operationMode": operationMode,
        if (responseInfo != null)
          "responseInfo": List<dynamic>.from(responseInfo!.map((x) => x.toJson())),
      };
}

class Datum {
  int? serialNumber; // Made nullable
  String? otp; // Made nullable

  Datum({
    this.serialNumber,
    this.otp,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serialNumber: json["serialNumber"] as int?,
        otp: json["otp"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (serialNumber != null) "serialNumber": serialNumber,
        if (otp != null) "otp": otp,
      };
}

class ResponseInfo {
  int? msgCode; // Made nullable
  String? msgType; // Made nullable
  String? userMessage; // Made nullable

  ResponseInfo({
    this.msgCode,
    this.msgType,
    this.userMessage,
  });

  factory ResponseInfo.fromJson(Map<String, dynamic> json) => ResponseInfo(
        msgCode: json["msgCode"] as int?,
        msgType: json["msgType"] as String?,
        userMessage: json["userMessage"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (msgCode != null) "msgCode": msgCode,
        if (msgType != null) "msgType": msgType,
        if (userMessage != null) "userMessage": userMessage,
      };
}