// To parse this JSON data, do
//
//     final getServiceDetailsResponse = getServiceDetailsResponseFromJson(jsonString);

import 'dart:convert';

List<GetServiceDetailsResponse> getServiceDetailsResponseFromJson(String str) =>
    List<GetServiceDetailsResponse>.from(
        json.decode(str).map((x) => GetServiceDetailsResponse.fromJson(x ?? {})));

String getServiceDetailsResponseToJson(List<GetServiceDetailsResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetServiceDetailsResponse {
  String? timestamp;
  String? status;
  List<ServiceDetails>? data;
  String? operationMode;
  List<ResponseInfo>? responseInfo;

  GetServiceDetailsResponse({
    this.timestamp,
    this.status,
    this.data,
    this.operationMode,
    this.responseInfo,
  });

  factory GetServiceDetailsResponse.fromJson(Map<String, dynamic> json) =>
      GetServiceDetailsResponse(
        timestamp: json["timestamp"] as String?,
        status: json["status"] as String?,
        data: json["data"] != null
            ? List<ServiceDetails>.from(json["data"].map((x) => ServiceDetails.fromJson(x ?? {})))
            : null,
        operationMode: json["operationMode"] as String?,
        responseInfo: json["responseInfo"] != null
            ? List<ResponseInfo>.from(
                json["responseInfo"].map((x) => ResponseInfo.fromJson(x ?? {})))
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (timestamp != null) "timestamp": timestamp,
        if (status != null) "status": status,
        if (data != null) "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        if (operationMode != null) "operationMode": operationMode,
        if (responseInfo != null)
          "responseInfo": List<dynamic>.from(responseInfo!.map((x) => x.toJson())),
      };
}

class ServiceDetails {
  List<UserType>? userType;
  List<Gender>? gender;
  List<Status>? appointmentStatus;
  List<Status>? investigationStatus;
  List<MiRoom>? miRoom;
  List<Ama>? ama;
  List<Command>? command;
  List<Medical>? medical;

  ServiceDetails({
    this.userType,
    this.gender,
    this.appointmentStatus,
    this.investigationStatus,
    this.miRoom,
    this.ama,
    this.command,
    this.medical,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
        userType: json["userType"] != null
            ? List<UserType>.from(
                json["userType"].map((x) => UserType.fromJson(x ?? {})))
            : null,
        gender: json["gender"] != null
            ? List<Gender>.from(json["gender"].map((x) => Gender.fromJson(x ?? {})))
            : null,
        appointmentStatus: json["appointmentStatus"] != null
            ? List<Status>.from(
                json["appointmentStatus"].map((x) => Status.fromJson(x ?? {})))
            : null,
        investigationStatus: json["investigationStatus"] != null
            ? List<Status>.from(
                json["investigationStatus"].map((x) => Status.fromJson(x ?? {})))
            : null,
        miRoom: json["miRoom"] != null
            ? List<MiRoom>.from(json["miRoom"].map((x) => MiRoom.fromJson(x ?? {})))
            : null,
        ama: json["ama"] != null
            ? List<Ama>.from(json["ama"].map((x) => Ama.fromJson(x ?? {})))
            : null,
        command: json["command"] != null
            ? List<Command>.from(
                json["command"].map((x) => Command.fromJson(x ?? {})))
            : null,
        medical: json["medical"] != null
            ? List<Medical>.from(
                json["medical"].map((x) => Medical.fromJson(x ?? {})))
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (userType != null)
          "userType": List<dynamic>.from(userType!.map((x) => x.toJson())),
        if (gender != null)
          "gender": List<dynamic>.from(gender!.map((x) => x.toJson())),
        if (appointmentStatus != null)
          "appointmentStatus":
              List<dynamic>.from(appointmentStatus!.map((x) => x.toJson())),
        if (investigationStatus != null)
          "investigationStatus":
              List<dynamic>.from(investigationStatus!.map((x) => x.toJson())),
        if (miRoom != null)
          "miRoom": List<dynamic>.from(miRoom!.map((x) => x.toJson())),
        if (ama != null) "ama": List<dynamic>.from(ama!.map((x) => x.toJson())),
        if (command != null)
          "command": List<dynamic>.from(command!.map((x) => x.toJson())),
        if (medical != null)
          "medical": List<dynamic>.from(medical!.map((x) => x.toJson())),
      };
}

class Ama {
  String? amaPno;
  String? amaFullName;

  Ama({
    this.amaPno,
    this.amaFullName,
  });

  factory Ama.fromJson(Map<String, dynamic> json) => Ama(
        amaPno: json["amaPno"] as String?,
        amaFullName: json["amaFullName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (amaPno != null) "amaPno": amaPno,
        if (amaFullName != null) "amaFullName": amaFullName,
      };
}

class Status {
  int? stageCode;
  String? stageDescription;

  Status({
    this.stageCode,
    this.stageDescription,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        stageCode: json["stageCode"] as int?,
        stageDescription: json["stageDescription"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (stageCode != null) "stageCode": stageCode,
        if (stageDescription != null) "stageDescription": stageDescription,
      };
}

class Command {
  String? commandCode;
  String? commandName;

  Command({
    this.commandCode,
    this.commandName,
  });

  factory Command.fromJson(Map<String, dynamic> json) => Command(
        commandCode: json["commandCode"] as String?,
        commandName: json["commandName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (commandCode != null) "commandCode": commandCode,
        if (commandName != null) "commandName": commandName,
      };
}

class Gender {
  String? genderCode;
  String? genderName;

  Gender({
    this.genderCode,
    this.genderName,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        genderCode: json["genderCode"] as String?,
        genderName: json["genderName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (genderCode != null) "genderCode": genderCode,
        if (genderName != null) "genderName": genderName,
      };
}

class Medical {
  String? medicalCode;
  String? medicalName;

  Medical({
    this.medicalCode,
    this.medicalName,
  });

  factory Medical.fromJson(Map<String, dynamic> json) => Medical(
        medicalCode: json["medicalCode"] as String?,
        medicalName: json["medicalName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (medicalCode != null) "medicalCode": medicalCode,
        if (medicalName != null) "medicalName": medicalName,
      };
}

class MiRoom {
  String? miUnitCode;
  String? miUnitName;

  MiRoom({
    this.miUnitCode,
    this.miUnitName,
  });

  factory MiRoom.fromJson(Map<String, dynamic> json) => MiRoom(
        miUnitCode: json["miUnitCode"] as String?,
        miUnitName: json["miUnitName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (miUnitCode != null) "miUnitCode": miUnitCode,
        if (miUnitName != null) "miUnitName": miUnitName,
      };
}

class UserType {
  String? userTypeCode;
  String? userTypeName;

  UserType({
    this.userTypeCode,
    this.userTypeName,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        userTypeCode: json["userTypeCode"] as String?,
        userTypeName: json["userTypeName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (userTypeCode != null) "userTypeCode": userTypeCode,
        if (userTypeName != null) "userTypeName": userTypeName,
      };
}

class ResponseInfo {
  int? msgCode;
  String? msgType;
  String? userMessage;

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