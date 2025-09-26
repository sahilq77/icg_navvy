// To parse this JSON data, do
//
//     final getDueDateResponse = getDueDateResponseFromJson(jsonString);

import 'dart:convert';

List<GetDueDateResponse> getDueDateResponseFromJson(String str) =>
    List<GetDueDateResponse>.from(
      json.decode(str).map((x) => GetDueDateResponse.fromJson(x)),
    );

String getDueDateResponseToJson(List<GetDueDateResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDueDateResponse {
  String timestamp;
  String status;
  List<DueDateData> data;
  String operationMode;
  List<ResponseInfo> responseInfo;

  GetDueDateResponse({
    required this.timestamp,
    required this.status,
    required this.data,
    required this.operationMode,
    required this.responseInfo,
  });

  factory GetDueDateResponse.fromJson(Map<String, dynamic> json) =>
      GetDueDateResponse(
        timestamp: json["timestamp"],
        status: json["status"],
        data: List<DueDateData>.from(json["data"].map((x) => DueDateData.fromJson(x))),
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

class DueDateData {
  int rankId;
  String rankCode;
  int fromMonth;
  int toMonth;
  int isActive;
  String createdBy;
  DateTime createdDate;
  DateTime scheduledDueDate;

  DueDateData({
    required this.rankId,
    required this.rankCode,
    required this.fromMonth,
    required this.toMonth,
    required this.isActive,
    required this.createdBy,
    required this.createdDate,
    required this.scheduledDueDate,
  });

  factory DueDateData.fromJson(Map<String, dynamic> json) => DueDateData(
    rankId: json["rankId"] ?? "",
    rankCode: json["rankCode"] ?? "",
    fromMonth: json["fromMonth"] ?? "",
    toMonth: json["toMonth"] ?? "",
    isActive: json["isActive"] ?? "",
    createdBy: json["createdBy"] ?? "",
    createdDate: DateTime.parse(json["createdDate"]),
    scheduledDueDate: DateTime.parse(json["scheduledDueDate"]),
  );

  Map<String, dynamic> toJson() => {
    "rankId": rankId,
    "rankCode": rankCode,
    "fromMonth": fromMonth,
    "toMonth": toMonth,
    "isActive": isActive,
    "createdBy": createdBy,
    "createdDate": createdDate.toIso8601String(),
    "scheduledDueDate":
        "${scheduledDueDate.year.toString().padLeft(4, '0')}-${scheduledDueDate.month.toString().padLeft(2, '0')}-${scheduledDueDate.day.toString().padLeft(2, '0')}",
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
    msgCode: json["msgCode"] ?? "",
    msgType: json["msgType"] ?? "",
    userMessage: json["userMessage"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "msgCode": msgCode,
    "msgType": msgType,
    "userMessage": userMessage,
  };
}
