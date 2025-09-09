
import 'dart:convert';

List<GetRankResponse> getRankResponseFromJson(String str) =>
    List<GetRankResponse>.from(json.decode(str).map((x) => GetRankResponse.fromJson(x)));

String getRankResponseToJson(List<GetRankResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetRankResponse {
  String? timestamp; // Made nullable
  String? status; // Made nullable
  List<RankData>? data; // Made nullable
  String? operationMode; // Made nullable
  List<ResponseInfo>? responseInfo; // Made nullable

  GetRankResponse({
    this.timestamp,
    this.status,
    this.data,
    this.operationMode,
    this.responseInfo,
  });

  factory GetRankResponse.fromJson(Map<String, dynamic> json) => GetRankResponse(
        timestamp: json["timestamp"] as String?,
        status: json["status"] as String?,
        data: json["data"] != null
            ? List<RankData>.from(json["data"].map((x) => RankData.fromJson(x)))
            : null,
        operationMode: json["operationMode"] as String?,
        responseInfo: json["responseInfo"] != null
            ? List<ResponseInfo>.from(json["responseInfo"].map((x) => ResponseInfo.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (timestamp != null) "timestamp": timestamp,
        if (status != null) "status": status,
        if (data != null) "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        if (operationMode != null) "operationMode": operationMode,
        if (responseInfo != null) "responseInfo": List<dynamic>.from(responseInfo!.map((x) => x.toJson())),
      };
}

class RankData {
  List<Rank>? rank; // Made nullable

  RankData({
    this.rank,
  });

  factory RankData.fromJson(Map<String, dynamic> json) => RankData(
        rank: json["rank"] != null
            ? List<Rank>.from(json["rank"].map((x) => Rank.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (rank != null) "rank": List<dynamic>.from(rank!.map((x) => x.toJson())),
      };
}

class Rank {
  String? rankCode; // Made nullable
  String? rankName; // Made nullable

  Rank({
    this.rankCode,
    this.rankName,
  });

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
        rankCode: json["rankCode"] as String?,
        rankName: json["rankName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (rankCode != null) "rankCode": rankCode,
        if (rankName != null) "rankName": rankName,
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