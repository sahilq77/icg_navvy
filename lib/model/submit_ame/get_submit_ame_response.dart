// To parse this JSON data, do
//
//     final getSubmitAmeResponse = getSubmitAmeResponseFromJson(jsonString);

import 'dart:convert';

List<GetSubmitAmeResponse> getSubmitAmeResponseFromJson(String str) =>
    List<GetSubmitAmeResponse>.from(json.decode(str).map((x) => GetSubmitAmeResponse.fromJson(x)));

String getSubmitAmeResponseToJson(List<GetSubmitAmeResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSubmitAmeResponse {
  String? timestamp;
  String? status;
  List<Datum>? data;
  String? operationMode;
  List<ResponseInfo>? responseInfo;

  GetSubmitAmeResponse({
    this.timestamp,
    this.status,
    this.data,
    this.operationMode,
    this.responseInfo,
  });

  factory GetSubmitAmeResponse.fromJson(Map<String, dynamic> json) => GetSubmitAmeResponse(
        timestamp: json["timestamp"],
        status: json["status"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
        operationMode: json["operationMode"],
        responseInfo: json["responseInfo"] != null
            ? List<ResponseInfo>.from(json["responseInfo"].map((x) => ResponseInfo.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "status": status,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
        "operationMode": operationMode,
        "responseInfo": responseInfo != null
            ? List<dynamic>.from(responseInfo!.map((x) => x.toJson()))
            : null,
      };
}

class Datum {
  int? serialNumber;
  int? companyCode;
  int? divisionCode;
  int? locationCode;
  int? personalSerialNumber;
  String? appointmentNumber;
  DateTime? appointmentDate;
  dynamic appointmentSlotNumber;
  dynamic appointmentSlotTimming;
  dynamic appointmentType;
  dynamic retestDate;
  int? creatorRoleCode;
  dynamic nextUpdatorRoleCode;
  dynamic modifierRoleCode;
  int? appointmentStage;
  int? appointmentStatus;
  dynamic amendmentNumber;
  dynamic amendmentDate;
  String? createdBy;
  dynamic modifiedBy;
  dynamic modifiedDate;
  dynamic ipAddress;
  DateTime? createdDate;
  dynamic hibernateVersionNo;
  dynamic auditTrailYn;
  String? personalNumber;
  String? createdByName;
  String? createdByUnitCode;
  String? createdByUnitName;
  dynamic amaPersonalNumber;
  String? declaration;
  String? personalMobileNumber;
  DateTime? dueDate;
  String? unitCode;
  String? appointmentRemarks;
  dynamic amePmeDate;
  DateTime? applyBeforeDate;
  String? personalPreferredDate;
  int? appointmentYear;
  int? diverYn;
  int? submarinerYn;
  int? marcoYn;
  int? aviatorYn;
  int? reemployeedYn;
  int? sdOfficerYn;
  int? noneOfAboveYn;
  dynamic petRemarks;
  dynamic offlineYn;
  AppointmentPersonDetail? appointmentPersonDetail;
  dynamic investigationDentalDetail;
  dynamic investigationPhysicalCapacityDetail;
  dynamic investigationCardioRespiratoryDetail;
  dynamic investigationGastroIntestinalSystemDetail;
  dynamic investigationCentralNervousSystemDetail;
  dynamic investigationInvesDetail;
  dynamic investigationGynechologistDetail;
  dynamic investigationEntDetail;
  dynamic investigationEyeDetail;
  dynamic investigationSurgeryDetail;
  dynamic finalObservationDetail;
  dynamic approverDetail;
  dynamic investigationDocumentDetail;
  dynamic investigationPrescriptionDetail;
  dynamic investigationVaccineDetail;
  dynamic investigationAdditionalParameterDetail;
  dynamic appointmentConfirmationDetail;
  dynamic investigationGeneralRemarksDtos;
  dynamic investigationFinalObservation4Edossier;
  dynamic peruserDetail;
  dynamic investigationAviationObservationDetail;
  dynamic investigationMarineObservationDetail;
  DateTime? medicalEffectFromDate;
  dynamic digiSignedFileUrl;
  dynamic isCreatorEsignAgain;
  dynamic isReady;
  dynamic digiSignFlag;
  dynamic unsignedFileUrl;
  dynamic partialDigitalSignYn;
  dynamic airCrewDiverYn;

  Datum({
    this.serialNumber,
    this.companyCode,
    this.divisionCode,
    this.locationCode,
    this.personalSerialNumber,
    this.appointmentNumber,
    this.appointmentDate,
    this.appointmentSlotNumber,
    this.appointmentSlotTimming,
    this.appointmentType,
    this.retestDate,
    this.creatorRoleCode,
    this.nextUpdatorRoleCode,
    this.modifierRoleCode,
    this.appointmentStage,
    this.appointmentStatus,
    this.amendmentNumber,
    this.amendmentDate,
    this.createdBy,
    this.modifiedBy,
    this.modifiedDate,
    this.ipAddress,
    this.createdDate,
    this.hibernateVersionNo,
    this.auditTrailYn,
    this.personalNumber,
    this.createdByName,
    this.createdByUnitCode,
    this.createdByUnitName,
    this.amaPersonalNumber,
    this.declaration,
    this.personalMobileNumber,
    this.dueDate,
    this.unitCode,
    this.appointmentRemarks,
    this.amePmeDate,
    this.applyBeforeDate,
    this.personalPreferredDate,
    this.appointmentYear,
    this.diverYn,
    this.submarinerYn,
    this.marcoYn,
    this.aviatorYn,
    this.reemployeedYn,
    this.sdOfficerYn,
    this.noneOfAboveYn,
    this.petRemarks,
    this.offlineYn,
    this.appointmentPersonDetail,
    this.investigationDentalDetail,
    this.investigationPhysicalCapacityDetail,
    this.investigationCardioRespiratoryDetail,
    this.investigationGastroIntestinalSystemDetail,
    this.investigationCentralNervousSystemDetail,
    this.investigationInvesDetail,
    this.investigationGynechologistDetail,
    this.investigationEntDetail,
    this.investigationEyeDetail,
    this.investigationSurgeryDetail,
    this.finalObservationDetail,
    this.approverDetail,
    this.investigationDocumentDetail,
    this.investigationPrescriptionDetail,
    this.investigationVaccineDetail,
    this.investigationAdditionalParameterDetail,
    this.appointmentConfirmationDetail,
    this.investigationGeneralRemarksDtos,
    this.investigationFinalObservation4Edossier,
    this.peruserDetail,
    this.investigationAviationObservationDetail,
    this.investigationMarineObservationDetail,
    this.medicalEffectFromDate,
    this.digiSignedFileUrl,
    this.isCreatorEsignAgain,
    this.isReady,
    this.digiSignFlag,
    this.unsignedFileUrl,
    this.partialDigitalSignYn,
    this.airCrewDiverYn,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serialNumber: json["serialNumber"],
        companyCode: json["companyCode"],
        divisionCode: json["divisionCode"],
        locationCode: json["locationCode"],
        personalSerialNumber: json["personalSerialNumber"],
        appointmentNumber: json["appointmentNumber"],
        appointmentDate: json["appointmentDate"] != null
            ? DateTime.tryParse(json["appointmentDate"])
            : null,
        appointmentSlotNumber: json["appointmentSlotNumber"],
        appointmentSlotTimming: json["appointmentSlotTimming"],
        appointmentType: json["appointmentType"],
        retestDate: json["retestDate"],
        creatorRoleCode: json["creatorRoleCode"],
        nextUpdatorRoleCode: json["nextUpdatorRoleCode"],
        modifierRoleCode: json["modifierRoleCode"],
        appointmentStage: json["appointmentStage"],
        appointmentStatus: json["appointmentStatus"],
        amendmentNumber: json["amendmentNumber"],
        amendmentDate: json["amendmentDate"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
        ipAddress: json["ipAddress"],
        createdDate: json["createdDate"] != null
            ? DateTime.tryParse(json["createdDate"])
            : null,
        hibernateVersionNo: json["hibernateVersionNo"],
        auditTrailYn: json["auditTrailYn"],
        personalNumber: json["personalNumber"],
        createdByName: json["createdByName"],
        createdByUnitCode: json["createdByUnitCode"],
        createdByUnitName: json["createdByUnitName"],
        amaPersonalNumber: json["amaPersonalNumber"],
        declaration: json["declaration"],
        personalMobileNumber: json["personalMobileNumber"],
        dueDate: json["dueDate"] != null ? DateTime.tryParse(json["dueDate"]) : null,
        unitCode: json["unitCode"],
        appointmentRemarks: json["appointmentRemarks"],
        amePmeDate: json["amePmeDate"],
        applyBeforeDate: json["applyBeforeDate"] != null
            ? DateTime.tryParse(json["applyBeforeDate"])
            : null,
        personalPreferredDate: json["personalPreferredDate"],
        appointmentYear: json["appointmentYear"],
        diverYn: json["diverYn"],
        submarinerYn: json["submarinerYn"],
        marcoYn: json["marcoYn"],
        aviatorYn: json["aviatorYn"],
        reemployeedYn: json["reemployeedYn"],
        sdOfficerYn: json["sdOfficerYn"],
        noneOfAboveYn: json["noneOfAboveYn"],
        petRemarks: json["petRemarks"],
        offlineYn: json["offlineYn"],
        appointmentPersonDetail: json["appointmentPersonDetail"] != null
            ? AppointmentPersonDetail.fromJson(json["appointmentPersonDetail"])
            : null,
        investigationDentalDetail: json["investigationDentalDetail"],
        investigationPhysicalCapacityDetail:
            json["investigationPhysicalCapacityDetail"],
        investigationCardioRespiratoryDetail:
            json["investigationCardioRespiratoryDetail"],
        investigationGastroIntestinalSystemDetail:
            json["investigationGastroIntestinalSystemDetail"],
        investigationCentralNervousSystemDetail:
            json["investigationCentralNervousSystemDetail"],
        investigationInvesDetail: json["investigationInvesDetail"],
        investigationGynechologistDetail: json["investigationGynechologistDetail"],
        investigationEntDetail: json["investigationEntDetail"],
        investigationEyeDetail: json["investigationEyeDetail"],
        investigationSurgeryDetail: json["investigationSurgeryDetail"],
        finalObservationDetail: json["finalObservationDetail"],
        approverDetail: json["approverDetail"],
        investigationDocumentDetail: json["investigationDocumentDetail"],
        investigationPrescriptionDetail: json["investigationPrescriptionDetail"],
        investigationVaccineDetail: json["investigationVaccineDetail"],
        investigationAdditionalParameterDetail:
            json["investigationAdditionalParameterDetail"],
        appointmentConfirmationDetail: json["appointmentConfirmationDetail"],
        investigationGeneralRemarksDtos: json["investigationGeneralRemarksDtos"],
        investigationFinalObservation4Edossier:
            json["investigationFinalObservation4Edossier"],
        peruserDetail: json["peruserDetail"],
        investigationAviationObservationDetail:
            json["investigationAviationObservationDetail"],
        investigationMarineObservationDetail:
            json["investigationMarineObservationDetail"],
        medicalEffectFromDate: json["medicalEffectFromDate"] != null
            ? DateTime.tryParse(json["medicalEffectFromDate"])
            : null,
        digiSignedFileUrl: json["digiSignedFileUrl"],
        isCreatorEsignAgain: json["isCreatorEsignAgain"],
        isReady: json["isReady"],
        digiSignFlag: json["digiSignFlag"],
        unsignedFileUrl: json["unsignedFileUrl"],
        partialDigitalSignYn: json["partialDigitalSignYn"],
        airCrewDiverYn: json["airCrewDiverYn"],
      );

  Map<String, dynamic> toJson() => {
        "serialNumber": serialNumber,
        "companyCode": companyCode,
        "divisionCode": divisionCode,
        "locationCode": locationCode,
        "personalSerialNumber": personalSerialNumber,
        "appointmentNumber": appointmentNumber,
        "appointmentDate": appointmentDate?.toIso8601String(),
        "appointmentSlotNumber": appointmentSlotNumber,
        "appointmentSlotTimming": appointmentSlotTimming,
        "appointmentType": appointmentType,
        "retestDate": retestDate,
        "creatorRoleCode": creatorRoleCode,
        "nextUpdatorRoleCode": nextUpdatorRoleCode,
        "modifierRoleCode": modifierRoleCode,
        "appointmentStage": appointmentStage,
        "appointmentStatus": appointmentStatus,
        "amendmentNumber": amendmentNumber,
        "amendmentDate": amendmentDate,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
        "ipAddress": ipAddress,
        "createdDate": createdDate?.toIso8601String(),
        "hibernateVersionNo": hibernateVersionNo,
        "auditTrailYn": auditTrailYn,
        "personalNumber": personalNumber,
        "createdByName": createdByName,
        "createdByUnitCode": createdByUnitCode,
        "createdByUnitName": createdByUnitName,
        "amaPersonalNumber": amaPersonalNumber,
        "declaration": declaration,
        "personalMobileNumber": personalMobileNumber,
        "dueDate": dueDate?.toIso8601String(),
        "unitCode": unitCode,
        "appointmentRemarks": appointmentRemarks,
        "amePmeDate": amePmeDate,
        "applyBeforeDate": applyBeforeDate?.toIso8601String(),
        "personalPreferredDate": personalPreferredDate,
        "appointmentYear": appointmentYear,
        "diverYn": diverYn,
        "submarinerYn": submarinerYn,
        "marcoYn": marcoYn,
        "aviatorYn": aviatorYn,
        "reemployeedYn": reemployeedYn,
        "sdOfficerYn": sdOfficerYn,
        "noneOfAboveYn": noneOfAboveYn,
        "petRemarks": petRemarks,
        "offlineYn": offlineYn,
        "appointmentPersonDetail": appointmentPersonDetail?.toJson(),
        "investigationDentalDetail": investigationDentalDetail,
        "investigationPhysicalCapacityDetail": investigationPhysicalCapacityDetail,
        "investigationCardioRespiratoryDetail":
            investigationCardioRespiratoryDetail,
        "investigationGastroIntestinalSystemDetail":
            investigationGastroIntestinalSystemDetail,
        "investigationCentralNervousSystemDetail":
            investigationCentralNervousSystemDetail,
        "investigationInvesDetail": investigationInvesDetail,
        "investigationGynechologistDetail": investigationGynechologistDetail,
        "investigationEntDetail": investigationEntDetail,
        "investigationEyeDetail": investigationEyeDetail,
        "investigationSurgeryDetail": investigationSurgeryDetail,
        "finalObservationDetail": finalObservationDetail,
        "approverDetail": approverDetail,
        "investigationDocumentDetail": investigationDocumentDetail,
        "investigationPrescriptionDetail": investigationPrescriptionDetail,
        "investigationVaccineDetail": investigationVaccineDetail,
        "investigationAdditionalParameterDetail":
            investigationAdditionalParameterDetail,
        "appointmentConfirmationDetail": appointmentConfirmationDetail,
        "investigationGeneralRemarksDtos": investigationGeneralRemarksDtos,
        "investigationFinalObservation4Edossier":
            investigationFinalObservation4Edossier,
        "peruserDetail": peruserDetail,
        "investigationAviationObservationDetail":
            investigationAviationObservationDetail,
        "investigationMarineObservationDetail":
            investigationMarineObservationDetail,
        "medicalEffectFromDate": medicalEffectFromDate?.toIso8601String(),
        "digiSignedFileUrl": digiSignedFileUrl,
        "isCreatorEsignAgain": isCreatorEsignAgain,
        "isReady": isReady,
        "digiSignFlag": digiSignFlag,
        "unsignedFileUrl": unsignedFileUrl,
        "partialDigitalSignYn": partialDigitalSignYn,
        "airCrewDiverYn": airCrewDiverYn,
      };
}

class AppointmentPersonDetail {
  String? employeeGender;
  DateTime? dateOfBirth;
  String? rankCode;
  DateTime? dateOfCommissioning;
  String? unitCode;
  String? commandCode;
  String? branchCode;
  String? serviceCode;
  String? typeOfCommission;
  DateTime? lastInvestigationDate;
  String? lastInvestigationUnitCode;
  String? currentMedicalCategory;
  String? pastMedicalHistory;
  DateTime? medicalEffectFromDate;
  String? bloodGroupCode;

  AppointmentPersonDetail({
    this.employeeGender,
    this.dateOfBirth,
    this.rankCode,
    this.dateOfCommissioning,
    this.unitCode,
    this.commandCode,
    this.branchCode,
    this.serviceCode,
    this.typeOfCommission,
    this.lastInvestigationDate,
    this.lastInvestigationUnitCode,
    this.currentMedicalCategory,
    this.pastMedicalHistory,
    this.medicalEffectFromDate,
    this.bloodGroupCode,
  });

  factory AppointmentPersonDetail.fromJson(Map<String, dynamic> json) =>
      AppointmentPersonDetail(
        employeeGender: json["employeeGender"],
        dateOfBirth:
            json["dateOfBirth"] != null ? DateTime.tryParse(json["dateOfBirth"]) : null,
        rankCode: json["rankCode"],
        dateOfCommissioning: json["dateOfCommissioning"] != null
            ? DateTime.tryParse(json["dateOfCommissioning"])
            : null,
        unitCode: json["unitCode"],
        commandCode: json["commandCode"],
        branchCode: json["branchCode"],
        serviceCode: json["serviceCode"],
        typeOfCommission: json["typeOfCommission"],
        lastInvestigationDate: json["lastInvestigationDate"] != null
            ? DateTime.tryParse(json["lastInvestigationDate"])
            : null,
        lastInvestigationUnitCode: json["lastInvestigationUnitCode"],
        currentMedicalCategory: json["currentMedicalCategory"],
        pastMedicalHistory: json["pastMedicalHistory"],
        medicalEffectFromDate: json["medicalEffectFromDate"] != null
            ? DateTime.tryParse(json["medicalEffectFromDate"])
            : null,
        bloodGroupCode: json["bloodGroupCode"],
      );

  Map<String, dynamic> toJson() => {
        "employeeGender": employeeGender,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "rankCode": rankCode,
        "dateOfCommissioning": dateOfCommissioning?.toIso8601String(),
        "unitCode": unitCode,
        "commandCode": commandCode,
        "branchCode": branchCode,
        "serviceCode": serviceCode,
        "typeOfCommission": typeOfCommission,
        "lastInvestigationDate": lastInvestigationDate?.toIso8601String(),
        "lastInvestigationUnitCode": lastInvestigationUnitCode,
        "currentMedicalCategory": currentMedicalCategory,
        "pastMedicalHistory": pastMedicalHistory,
        "medicalEffectFromDate": medicalEffectFromDate?.toIso8601String(),
        "bloodGroupCode": bloodGroupCode,
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