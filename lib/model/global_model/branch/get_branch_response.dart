// To parse this JSON data, do
//
//     final getBranchResponse = getBranchResponseFromJson(jsonString);

import 'dart:convert';

List<GetBranchResponse> getBranchResponseFromJson(String str) => List<GetBranchResponse>.from(json.decode(str).map((x) => GetBranchResponse.fromJson(x)));

String getBranchResponseToJson(List<GetBranchResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBranchResponse {
    String timestamp;
    String status;
    List<BranchData> data;
    String operationMode;
    List<ResponseInfo> responseInfo;

    GetBranchResponse({
        required this.timestamp,
        required this.status,
        required this.data,
        required this.operationMode,
        required this.responseInfo,
    });

    factory GetBranchResponse.fromJson(Map<String, dynamic> json) => GetBranchResponse(
        timestamp: json["timestamp"],
        status: json["status"],
        data: List<BranchData>.from(json["data"].map((x) => BranchData.fromJson(x))),
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

class BranchData {
    String id;
    String value;

    BranchData({
        required this.id,
        required this.value,
    });

    factory BranchData.fromJson(Map<String, dynamic> json) => BranchData(
        id: json["id"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
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
