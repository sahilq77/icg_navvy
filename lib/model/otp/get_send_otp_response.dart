// To parse this JSON data, do
//
//     final getSendOtpResponse = getSendOtpResponseFromJson(jsonString);

import 'dart:convert';

List<GetSendOtpResponse> getSendOtpResponseFromJson(String str) => List<GetSendOtpResponse>.from(json.decode(str).map((x) => GetSendOtpResponse.fromJson(x)));

String getSendOtpResponseToJson(List<GetSendOtpResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSendOtpResponse {
    String timestamp;
    String status;
    List<Datum> data;
    String operationMode;
    List<ResponseInfo> responseInfo;

    GetSendOtpResponse({
        required this.timestamp,
        required this.status,
        required this.data,
        required this.operationMode,
        required this.responseInfo,
    });

    factory GetSendOtpResponse.fromJson(Map<String, dynamic> json) => GetSendOtpResponse(
        timestamp: json["timestamp"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        operationMode: json["operationMode"],
        responseInfo: List<ResponseInfo>.from(json["responseInfo"].map((x) => ResponseInfo.fromJson(x))),
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
    int serialNumber;
    String otp;

    Datum({
        required this.serialNumber,
        required this.otp,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serialNumber: json["serialNumber"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "serialNumber": serialNumber,
        "otp": otp,
    };
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
