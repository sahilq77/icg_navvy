import 'dart:convert';

List<GetLoginResponse> getLoginResponseFromJson(String str) =>
    List<GetLoginResponse>.from(
      json.decode(str).map((x) => GetLoginResponse.fromJson(x)),
    );

String getLoginResponseToJson(List<GetLoginResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetLoginResponse {
  String? timestamp; // Made nullable
  String? status; // Made nullable
  List<UserData>? data; // Made nullable
  String? operationMode; // Made nullable
  List<ResponseInfo>? responseInfo; // Made nullable

  GetLoginResponse({
    this.timestamp,
    this.status,
    this.data,
    this.operationMode,
    this.responseInfo,
  });

  factory GetLoginResponse.fromJson(Map<String, dynamic> json) =>
      GetLoginResponse(
        timestamp: json["timestamp"] as String?,
        status: json["status"] as String?,
        data: json["data"] == null
            ? null
            : List<UserData>.from(
                json["data"].map((x) => UserData.fromJson(x)),
              ),
        operationMode: json["operationMode"] as String?,
        responseInfo: json["responseInfo"] == null
            ? null
            : List<ResponseInfo>.from(
                json["responseInfo"].map((x) => ResponseInfo.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp,
    "status": status,
    "data": data == null
        ? null
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "operationMode": operationMode,
    "responseInfo": responseInfo == null
        ? null
        : List<dynamic>.from(responseInfo!.map((x) => x.toJson())),
  };
}

class UserData {
  Personnel? personnel; // Made nullable
  dynamic documents;
  dynamic condonationDocument;
  dynamic finalObservation;
  dynamic approverDetails;
  dynamic peruserDetail;
  dynamic vaccineDetails;
  dynamic petDetail;
  dynamic aviationObservationDetail;
  dynamic marineObservationDetail;
  List<Misc>? misc; // Made nullable

  UserData({
    required this.personnel,
    required this.documents,
    required this.condonationDocument,
    required this.finalObservation,
    required this.approverDetails,
    required this.peruserDetail,
    required this.vaccineDetails,
    required this.petDetail,
    required this.aviationObservationDetail,
    required this.marineObservationDetail,
    required this.misc,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    personnel: json["personnel"] == null
        ? null
        : Personnel.fromJson(json["personnel"]),
    documents: json["documents"],
    condonationDocument: json["condonationDocument"],
    finalObservation: json["finalObservation"],
    approverDetails: json["approverDetails"],
    peruserDetail: json["peruserDetail"],
    vaccineDetails: json["vaccineDetails"],
    petDetail: json["petDetail"],
    aviationObservationDetail: json["aviationObservationDetail"],
    marineObservationDetail: json["marineObservationDetail"],
    misc: json["misc"] == null
        ? null
        : List<Misc>.from(json["misc"].map((x) => Misc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "personnel": personnel?.toJson(),
    "documents": documents,
    "condonationDocument": condonationDocument,
    "finalObservation": finalObservation,
    "approverDetails": approverDetails,
    "peruserDetail": peruserDetail,
    "vaccineDetails": vaccineDetails,
    "petDetail": petDetail,
    "aviationObservationDetail": aviationObservationDetail,
    "marineObservationDetail": marineObservationDetail,
    "misc": misc == null
        ? null
        : List<dynamic>.from(misc!.map((x) => x.toJson())),
  };
}

class Misc {
  String? authorityNumber; // Made nullable

  Misc({this.authorityNumber});

  factory Misc.fromJson(Map<String, dynamic> json) =>
      Misc(authorityNumber: json["authorityNumber"] as String?);

  Map<String, dynamic> toJson() => {"authorityNumber": authorityNumber};
}

class Personnel {
  dynamic serialNumber;
  int? personalSerialNumber; // Made nullable
  String? personalNumber; // Made nullable
  String? firstName; // Made nullable
  String? middleName; // Made nullable
  String? lastName; // Made nullable
  String? fullName; // Made nullable
  String? employeeGender; // Made nullable
  DateTime? dateOfBirth; // Made nullable
  String? age; // Made nullable
  String? unitCode; // Made nullable
  String? unitName; // Made nullable
  String? rankCode; // Made nullable
  String? rankName; // Made nullable
  String? rankShortName; // Made nullable
  String? branchCode; // Made nullable
  String? branchName; // Made nullable
  DateTime? dateOfCommissioning; // Made nullable
  dynamic dateOfJoining;
  String? totalService; // Made nullable
  String? serviceCode; // Made nullable
  String? serviceName; // Made nullable
  String? typeOfCommission; // Made nullable
  dynamic appointmentStatus;
  dynamic appointmentStage;
  DateTime? lastInvestigationDate; // Made nullable
  String? lastInvestigationUnitCode; // Made nullable
  dynamic investigationAuthorityPersonNumber;
  dynamic investigationUnitCode;
  dynamic investigationUnitName;
  dynamic otherLastInvestigationUnitName;
  String? lastInvestigationUnitName; // Made nullable
  String? commandCode; // Made nullable
  String? commandName; // Made nullable
  String? pastMedicalHistory; // Made nullable
  String? currentMedicalCategory; // Made nullable
  dynamic appointmentNumber;
  dynamic appointmentSerialNumber;
  dynamic investigationDate;
  DateTime? medicalCategoryWithEffectFrom; // Made nullable
  String? personalMobileNumber; // Made nullable
  dynamic dueDate;
  String? userTypeCode; // Made nullable
  String? bloodGroupCode; // Made nullable
  dynamic applyBeforeDate;

  Personnel({
    this.serialNumber,
    this.personalSerialNumber,
    this.personalNumber,
    this.firstName,
    this.middleName,
    this.lastName,
    this.fullName,
    this.employeeGender,
    this.dateOfBirth,
    this.age,
    this.unitCode,
    this.unitName,
    this.rankCode,
    this.rankName,
    this.rankShortName,
    this.branchCode,
    this.branchName,
    this.dateOfCommissioning,
    this.dateOfJoining,
    this.totalService,
    this.serviceCode,
    this.serviceName,
    this.typeOfCommission,
    this.appointmentStatus,
    this.appointmentStage,
    this.lastInvestigationDate,
    this.lastInvestigationUnitCode,
    this.investigationAuthorityPersonNumber,
    this.investigationUnitCode,
    this.investigationUnitName,
    this.otherLastInvestigationUnitName,
    this.lastInvestigationUnitName,
    this.commandCode,
    this.commandName,
    this.pastMedicalHistory,
    this.currentMedicalCategory,
    this.appointmentNumber,
    this.appointmentSerialNumber,
    this.investigationDate,
    this.medicalCategoryWithEffectFrom,
    this.personalMobileNumber,
    this.dueDate,
    this.userTypeCode,
    this.bloodGroupCode,
    this.applyBeforeDate,
  });

  factory Personnel.fromJson(Map<String, dynamic> json) => Personnel(
    serialNumber: json["serialNumber"],
    personalSerialNumber: json["personalSerialNumber"] as int?,
    personalNumber: json["personalNumber"] as String?,
    firstName: json["firstName"] as String?,
    middleName: json["middleName"] as String?,
    lastName: json["lastName"] as String?,
    fullName: json["fullName"] as String?,
    employeeGender: json["employeeGender"] as String?,
    dateOfBirth: json["dateOfBirth"] == null
        ? null
        : DateTime.tryParse(json["dateOfBirth"] as String),
    age: json["age"] as String?,
    unitCode: json["unitCode"] as String?,
    unitName: json["unitName"] as String?,
    rankCode: json["rankCode"] as String?,
    rankName: json["rankName"] as String?,
    rankShortName: json["rankShortName"] as String?,
    branchCode: json["branchCode"] as String?,
    branchName: json["branchName"] as String?,
    dateOfCommissioning: json["dateOfCommissioning"] == null
        ? null
        : DateTime.tryParse(json["dateOfCommissioning"] as String),
    dateOfJoining: json["dateOfJoining"],
    totalService: json["totalService"] as String?,
    serviceCode: json["serviceCode"] as String?,
    serviceName: json["serviceName"] as String?,
    typeOfCommission: json["typeOfCommission"] as String?,
    appointmentStatus: json["appointmentStatus"],
    appointmentStage: json["appointmentStage"],
    lastInvestigationDate: json["lastInvestigationDate"] == null
        ? null
        : DateTime.tryParse(json["lastInvestigationDate"] as String),
    lastInvestigationUnitCode: json["lastInvestigationUnitCode"] as String?,
    investigationAuthorityPersonNumber:
        json["investigationAuthorityPersonNumber"],
    investigationUnitCode: json["investigationUnitCode"],
    investigationUnitName: json["investigationUnitName"],
    otherLastInvestigationUnitName: json["otherLastInvestigationUnitName"],
    lastInvestigationUnitName: json["lastInvestigationUnitName"] as String?,
    commandCode: json["commandCode"] as String?,
    commandName: json["commandName"] as String?,
    pastMedicalHistory: json["pastMedicalHistory"] as String?,
    currentMedicalCategory: json["currentMedicalCategory"] as String?,
    appointmentNumber: json["appointmentNumber"],
    appointmentSerialNumber: json["appointmentSerialNumber"],
    investigationDate: json["investigationDate"],
    medicalCategoryWithEffectFrom: json["medicalCategoryWithEffectFrom"] == null
        ? null
        : DateTime.tryParse(json["medicalCategoryWithEffectFrom"] as String),
    personalMobileNumber: json["personalMobileNumber"] as String?,
    dueDate: json["dueDate"],
    userTypeCode: json["userTypeCode"] as String?,
    bloodGroupCode: json["bloodGroupCode"] as String?,
    applyBeforeDate: json["applyBeforeDate"],
  );

  Map<String, dynamic> toJson() => {
    "serialNumber": serialNumber,
    "personalSerialNumber": personalSerialNumber,
    "personalNumber": personalNumber,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "fullName": fullName,
    "employeeGender": employeeGender,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "age": age,
    "unitCode": unitCode,
    "unitName": unitName,
    "rankCode": rankCode,
    "rankName": rankName,
    "rankShortName": rankShortName,
    "branchCode": branchCode,
    "branchName": branchName,
    "dateOfCommissioning": dateOfCommissioning?.toIso8601String(),
    "dateOfJoining": dateOfJoining,
    "totalService": totalService,
    "serviceCode": serviceCode,
    "serviceName": serviceName,
    "typeOfCommission": typeOfCommission,
    "appointmentStatus": appointmentStatus,
    "appointmentStage": appointmentStage,
    "lastInvestigationDate": lastInvestigationDate?.toIso8601String(),
    "lastInvestigationUnitCode": lastInvestigationUnitCode,
    "investigationAuthorityPersonNumber": investigationAuthorityPersonNumber,
    "investigationUnitCode": investigationUnitCode,
    "investigationUnitName": investigationUnitName,
    "otherLastInvestigationUnitName": otherLastInvestigationUnitName,
    "lastInvestigationUnitName": lastInvestigationUnitName,
    "commandCode": commandCode,
    "commandName": commandName,
    "pastMedicalHistory": pastMedicalHistory,
    "currentMedicalCategory": currentMedicalCategory,
    "appointmentNumber": appointmentNumber,
    "appointmentSerialNumber": appointmentSerialNumber,
    "investigationDate": investigationDate,
    "medicalCategoryWithEffectFrom": medicalCategoryWithEffectFrom
        ?.toIso8601String(),
    "personalMobileNumber": personalMobileNumber,
    "dueDate": dueDate,
    "userTypeCode": userTypeCode,
    "bloodGroupCode": bloodGroupCode,
    "applyBeforeDate": applyBeforeDate,
  };
}

class ResponseInfo {
  int? msgCode; // Made nullable
  String? msgType; // Made nullable
  String? userMessage; // Made nullable

  ResponseInfo({this.msgCode, this.msgType, this.userMessage});

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
