// To parse this JSON data, do
//
//     final getFinancialYearResponse = getFinancialYearResponseFromJson(jsonString);

import 'dart:convert';

List<GetFinancialYearResponse> getFinancialYearResponseFromJson(String str) => List<GetFinancialYearResponse>.from(json.decode(str).map((x) => GetFinancialYearResponse.fromJson(x)));

String getFinancialYearResponseToJson(List<GetFinancialYearResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFinancialYearResponse {
    String uniqueId;
    String timestamp;
    String status;
    List<FinancialYearData> data;
    String operationMode;
    Pagination pagination;
    List<ResponseInfo> responseInfo;

    GetFinancialYearResponse({
        required this.uniqueId,
        required this.timestamp,
        required this.status,
        required this.data,
        required this.operationMode,
        required this.pagination,
        required this.responseInfo,
    });

    factory GetFinancialYearResponse.fromJson(Map<String, dynamic> json) => GetFinancialYearResponse(
        uniqueId: json["uniqueId"],
        timestamp: json["timestamp"],
        status: json["status"],
        data: List<FinancialYearData>.from(json["data"].map((x) => FinancialYearData.fromJson(x))),
        operationMode: json["operationMode"],
        pagination: Pagination.fromJson(json["pagination"]),
        responseInfo: List<ResponseInfo>.from(json["responseInfo"].map((x) => ResponseInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "timestamp": timestamp,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "operationMode": operationMode,
        "pagination": pagination.toJson(),
        "responseInfo": List<dynamic>.from(responseInfo.map((x) => x.toJson())),
    };
}

class FinancialYearData {
    int financialYear;
    String financialDescription;
    String defaultYn;
    String activeYn;
    DateTime fromDate;
    DateTime toDate;
    String docNoString;
    String allowQueryYn;
    int companyCode;

    FinancialYearData({
        required this.financialYear,
        required this.financialDescription,
        required this.defaultYn,
        required this.activeYn,
        required this.fromDate,
        required this.toDate,
        required this.docNoString,
        required this.allowQueryYn,
        required this.companyCode,
    });

    factory FinancialYearData.fromJson(Map<String, dynamic> json) => FinancialYearData(
        financialYear: json["financialYear"],
        financialDescription: json["financialDescription"],
        defaultYn: json["defaultYn"],
        activeYn: json["activeYn"],
        fromDate: DateTime.parse(json["fromDate"]),
        toDate: DateTime.parse(json["toDate"]),
        docNoString: json["docNoString"],
        allowQueryYn: json["allowQueryYn"],
        companyCode: json["companyCode"],
    );

    Map<String, dynamic> toJson() => {
        "financialYear": financialYear,
        "financialDescription": financialDescription,
        "defaultYn": defaultYn,
        "activeYn": activeYn,
        "fromDate": "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "toDate": "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "docNoString": docNoString,
        "allowQueryYn": allowQueryYn,
        "companyCode": companyCode,
    };
}

class Pagination {
    int startIndex;
    int recordsPerPage;
    int totalRecordCount;
    int totalNoPage;
    int currentpage;

    Pagination({
        required this.startIndex,
        required this.recordsPerPage,
        required this.totalRecordCount,
        required this.totalNoPage,
        required this.currentpage,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        startIndex: json["startIndex"],
        recordsPerPage: json["recordsPerPage"],
        totalRecordCount: json["totalRecordCount"],
        totalNoPage: json["totalNoPage"],
        currentpage: json["currentpage"],
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
