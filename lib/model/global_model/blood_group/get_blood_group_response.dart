import 'dart:convert';

List<GetBloodGroupResponse> getBloodGroupResponseFromJson(String str) =>
    List<GetBloodGroupResponse>.from(json.decode(str).map((x) => GetBloodGroupResponse.fromJson(x)));

String getBloodGroupResponseToJson(List<GetBloodGroupResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBloodGroupResponse {
  String? uniqueId; // Made nullable
  String? timestamp; // Made nullable
  String? status; // Made nullable
  List<BloodGroupData>? data; // Made nullable
  String? operationMode; // Made nullable
  Pagination? pagination; // Made nullable
  List<ResponseInfo>? responseInfo; // Made nullable

  GetBloodGroupResponse({
    this.uniqueId,
    this.timestamp,
    this.status,
    this.data,
    this.operationMode,
    this.pagination,
    this.responseInfo,
  });

  factory GetBloodGroupResponse.fromJson(Map<String, dynamic> json) => GetBloodGroupResponse(
        uniqueId: json["uniqueId"] as String?,
        timestamp: json["timestamp"] as String?,
        status: json["status"] as String?,
        data: json["data"] == null
            ? null
            : List<BloodGroupData>.from(json["data"].map((x) => BloodGroupData.fromJson(x))),
        operationMode: json["operationMode"] as String?,
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        responseInfo: json["responseInfo"] == null
            ? null
            : List<ResponseInfo>.from(
                json["responseInfo"].map((x) => ResponseInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "timestamp": timestamp,
        "status": status,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "operationMode": operationMode,
        "pagination": pagination?.toJson(),
        "responseInfo": responseInfo == null
            ? null
            : List<dynamic>.from(responseInfo!.map((x) => x.toJson())),
      };
}

class BloodGroupData {
  int? bloodGroupId; // Made nullable
  String? bloodGroupCode; // Made nullable
  String? bloodGroupName; // Made nullable
  int? isActive; // Made nullable

  BloodGroupData({
    this.bloodGroupId,
    this.bloodGroupCode,
    this.bloodGroupName,
    this.isActive,
  });

  factory BloodGroupData.fromJson(Map<String, dynamic> json) => BloodGroupData(
        bloodGroupId: json["bloodGroupId"] as int?,
        bloodGroupCode: json["bloodGroupCode"] as String?,
        bloodGroupName: json["bloodGroupName"] as String?,
        isActive: json["isActive"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "bloodGroupId": bloodGroupId,
        "bloodGroupCode": bloodGroupCode,
        "bloodGroupName": bloodGroupName,
        "isActive": isActive,
      };
}

class Pagination {
  int? startIndex; // Made nullable
  int? recordsPerPage; // Made nullable
  int? totalRecordCount; // Made nullable
  int? totalNoPage; // Made nullable
  int? currentpage; // Made nullable

  Pagination({
    this.startIndex,
    this.recordsPerPage,
    this.totalRecordCount,
    this.totalNoPage,
    this.currentpage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        startIndex: json["startIndex"] as int?,
        recordsPerPage: json["recordsPerPage"] as int?,
        totalRecordCount: json["totalRecordCount"] as int?,
        totalNoPage: json["totalNoPage"] as int?,
        currentpage: json["currentpage"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "startIndex": startIndex,
        "recordsPerPage": recordsPerPage,
        "totalRecordCount": totalRecordCount,
        "totalNoPage": totalNoPage,
        "currentpage": currentpage,
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
        "msgCode": msgCode,
        "msgType": msgType,
        "userMessage": userMessage,
      };
}