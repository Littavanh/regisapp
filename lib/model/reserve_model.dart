// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:regisapp/model/respone_model.dart';
import 'package:regisapp/notification/socket/socket_controller.dart';
import 'package:regisapp/source/exception.dart';

import '../source/source.dart';

class ReserveModel {
  final int? id;

  final int? vaccineId;
  final int? vaccinationSiteId;
  final String date;
  final int level;
  final String? status;
  final String? isDelete;
  final String? createdAt;
  final String? updatedAt;

  ReserveModel({
    this.id,
    required this.vaccineId,
    required this.vaccinationSiteId,
    required this.date,
    required this.level,
    this.status,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  ReserveModel copyWith({
    int? id,
    String? userId,
    int? vaccineId,
    int? vaccinationSiteId,
    String? date,
    int? level,
    String? status,
    String? isDelete,
    String? createdAt,
    String? updatedAt,
  }) {
    return ReserveModel(
      id: id ?? this.id,
      vaccineId: vaccineId ?? this.vaccineId,
      vaccinationSiteId: vaccinationSiteId ?? this.vaccinationSiteId,
      date: date ?? this.date,
      level: level ?? this.level,
      status: status ?? this.status,
      isDelete: isDelete ?? this.isDelete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'vaccineId': vaccineId,
      'vaccinationSiteId': vaccinationSiteId,
      'date': date,
      'level': level,
      'status': status,
      'isDelete': isDelete,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ReserveModel.fromMap(Map<String, dynamic> map) {
    return ReserveModel(
      id: map['id'] != null ? map['id'] as int : null,
      vaccineId: map['id'] != null ? map['vaccineId'] as int : null,
      vaccinationSiteId:
          map['id'] != null ? map['vaccinationSiteId'] as int : null,
      date: map['date'] ?? '',
      level: map['level'],
      status: map['status'] != null ? map['status'] as String : null,
      isDelete: map['isDelete'] != null ? map['isDelete'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReserveModel.fromJson(String source) =>
      ReserveModel.fromMap(json.decode(source)['reserve'] as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReserveModel(id: $id, userId: $userId, vaccineId: $vaccineId, vaccinationSiteId: $vaccinationSiteId, date: $date, level: $level, status: $status, isDelete: $isDelete, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReserveModel &&
        other.id == id &&
        other.vaccineId == vaccineId &&
        other.vaccinationSiteId == vaccinationSiteId &&
        other.date == date &&
        other.level == level &&
        other.status == status &&
        other.isDelete == isDelete &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        vaccineId.hashCode ^
        vaccinationSiteId.hashCode ^
        date.hashCode ^
        level.hashCode ^
        status.hashCode ^
        isDelete.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  static Future<ReserveModel?> fetchMemberReserveNotification() async {
    try {
      final response = await http.get(Uri.parse(url + '/reserve/user'),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json'
          });
      if (response.statusCode == 200) {
        return ReserveModel.fromJson(response.body);
      } else {
        throw FetchDataException(error: response.body);
      }
    } on SocketException catch (e) {
      throw BadRequestException(error: e.toString());
    }
  }

  static Future<List<ReserveModel>> fetchMemberReserve(
      {String? status, String? date}) async {
    try {
      final response = await http.get(
          Uri.parse(url + '/reserve/getUserReserve?status=$status&date=$date'),
          headers: {'Authorization': token});
      if (response.statusCode == 200) {
        return json
            .decode(response.body)['reserve']
            .cast<Map<String, dynamic>>()
            .map<ReserveModel>((map) => ReserveModel.fromMap(map))
            .toList();
      } else {
        throw FetchDataException(error: response.body);
      }
    } on SocketException catch (e) {
      throw BadRequestException(error: e.toString());
    }
  }

  static Future<List<ReserveModel>> fetchAllReserve(
      {String? status, String? date}) async {
    try {
      String query = (date != null) ? '&date=$date' : '';
      final response = await http.get(
          Uri.parse(url + '/reserve?status=$status$query'),
          headers: {'Authorization': token});
      if (response.statusCode == 200) {
        return json
            .decode(response.body)['reserve']
            .cast<Map<String, dynamic>>()
            .map<ReserveModel>((map) => ReserveModel.fromMap(map))
            .toList();
      } else {
        throw FetchDataException(error: response.body);
      }
    } on SocketException catch (e) {
      throw BadRequestException(error: e.toString());
    }
  }

  static Future<List<ReserveModel>> fetchAllReserveNotification() async {
    try {
      final response = await http.get(Uri.parse(url + '/reserve/todayReserve'),
          headers: {'Authorization': token});
      if (response.statusCode == 200) {
        return json
            .decode(response.body)['reserve']
            .cast<Map<String, dynamic>>()
            .map<ReserveModel>((map) => ReserveModel.fromMap(map))
            .toList();
      } else {
        throw FetchDataException(error: response.body);
      }
    } on SocketException catch (e) {
      throw BadRequestException(error: e.toString());
    }
  }

  static Future<ResponseModel> postReserve({required ReserveModel data}) async {
    try {
      final post = await http.post(Uri.parse(url + '/reserve'),
          headers: {'Authorization': token, 'Content-Type': 'application/json'},
          body: data.toJson());
      if (post.statusCode == 201) {
        SocketController.sendNotification('notifi', "Add new reserve");
        return ResponseModel.fromJson(source: post.body, code: post.statusCode);
      } else {
        throw FetchDataException(error: post.body);
      }
    } on SocketException catch (e) {
      throw BadRequestException(error: e.toString());
    }
  }
// static Future<ResponseModel> postReserve({required ReserveModel data}) async {
//     try {
//       final request = http.MultipartRequest('POST', Uri.parse(url + '/reserve'));

//       request.headers
//           .addAll({'Authorization': token, 'Content-Type': 'application/json'});
//       request.fields['userId'] = data.userId;
//       request.fields['vaccineId'] = '${data.vaccineId}';
//       request.fields['vaccinationSiteId'] = '${data.vaccinationSiteId}';
//       request.fields['date'] = data.date;
//       request.fields['level'] = data.level;

//       final response = await request.send();
//       final reserve = await http.Response.fromStream(response);
//       if (reserve.statusCode == 201) {
//         SocketController.sendNotification('reserve', "Add news");
//         return ResponseModel.fromJson(source: reserve.body, code: reserve.statusCode);
//       } else {
//         throw BadRequestException(error: reserve.body);
//       }
//     } on SocketException catch (e) {
//       throw e.toString();
//     }
//   }

}
