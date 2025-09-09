// To parse this JSON data, do
//
//     final getServiceResponse = getServiceResponseFromJson(jsonString);

import 'dart:convert';

List<GetServiceResponse> getServiceResponseFromJson(String str) => List<GetServiceResponse>.from(json.decode(str).map((x) => GetServiceResponse.fromJson(x)));

String getServiceResponseToJson(List<GetServiceResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetServiceResponse {
    String timestamp;
    String status;
    List<Datum> data;
    String operationMode;
    List<ResponseInfo> responseInfo;

    GetServiceResponse({
        required this.timestamp,
        required this.status,
        required this.data,
        required this.operationMode,
        required this.responseInfo,
    });

    factory GetServiceResponse.fromJson(Map<String, dynamic> json) => GetServiceResponse(
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
    List<UserType> userType;
    List<ServiceType> serviceTypes;

    Datum({
        required this.userType,
        required this.serviceTypes,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userType: List<UserType>.from(json["userType"].map((x) => UserType.fromJson(x))),
        serviceTypes: List<ServiceType>.from(json["serviceTypes"].map((x) => ServiceType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userType": List<dynamic>.from(userType.map((x) => x.toJson())),
        "serviceTypes": List<dynamic>.from(serviceTypes.map((x) => x.toJson())),
    };
}

class ServiceType {
    String code;
    String name;

    ServiceType({
        required this.code,
        required this.name,
    });

    factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        code: json["code"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
    };
}

class UserType {
    String userTypeCode;
    String userTypeName;

    UserType({
        required this.userTypeCode,
        required this.userTypeName,
    });

    factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        userTypeCode: json["userTypeCode"],
        userTypeName: json["userTypeName"],
    );

    Map<String, dynamic> toJson() => {
        "userTypeCode": userTypeCode,
        "userTypeName": userTypeName,
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
