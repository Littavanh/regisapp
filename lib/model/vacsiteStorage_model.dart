// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:regisapp/model/vaccine_model.dart';
import 'package:regisapp/model/vacsite_model.dart';
import 'package:regisapp/source/exception.dart';
import 'package:regisapp/source/source.dart';

class VacsiteStorage {
 
final int? id;
 final int vaccineId;
 final int vaccinationSiteId;
 final int level;
 final int amount;
  final String? status;
 final String? createdAt;
final  String? updatedAt;
final VaccineModel? vaccine;
  final VacsiteModel? vacsite;
  VacsiteStorage({
    this.id,
    required this.vaccineId,
    required this.vaccinationSiteId,
    required this.level,
    required this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.vaccine,
    this.vacsite,
  });
 

  VacsiteStorage copyWith({
    int? id,
    int? vaccineId,
    int? vaccinationSiteId,
    int? level,
    int? amount,
    String? status,
    String? createdAt,
    String? updatedAt,
    VaccineModel? vaccine,
    VacsiteModel? vacsite,
  }) {
    return VacsiteStorage(
      id: id ?? this.id,
      vaccineId: vaccineId ?? this.vaccineId,
      vaccinationSiteId: vaccinationSiteId ?? this.vaccinationSiteId,
      level: level ?? this.level,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      vaccine: vaccine ?? this.vaccine,
      vacsite: vacsite ?? this.vacsite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'vaccineId': vaccineId,
      'vaccinationSiteId': vaccinationSiteId,
      'level': level,
      'amount': amount,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'vaccine': vaccine?.toMap(),
      'vacsite': vacsite?.toMap(),
    };
  }

  factory VacsiteStorage.fromMap(Map<String, dynamic> map) {
    return VacsiteStorage(
      id: map['id'] != null ? map['id'] as int : null,
      vaccineId: map['vaccineId'] as int,
      vaccinationSiteId: map['vaccinationSiteId'] as int,
      level: map['level'] as int,
      amount: map['amount'] as int,
      status: map['status'] != null ? map['status'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      vaccine: map['Vaccine'] != null ? VaccineModel.fromMap(map['Vaccine'] as Map<String,dynamic>) : null,
    
      vacsite: map['Vaccinationsite'] != null ? VacsiteModel.fromMap(map['Vaccinationsite'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VacsiteStorage.fromJson(String source) => VacsiteStorage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VacsiteStorage(id: $id, vaccineId: $vaccineId, vaccinationSiteId: $vaccinationSiteId, level: $level, amount: $amount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, vaccine: $vaccine, vacsite: $vacsite)';
  }

  @override
  bool operator ==(covariant VacsiteStorage other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.vaccineId == vaccineId &&
      other.vaccinationSiteId == vaccinationSiteId &&
      other.level == level &&
      other.amount == amount &&
      other.status == status &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.vaccine == vaccine &&
      other.vacsite == vacsite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      vaccineId.hashCode ^
      vaccinationSiteId.hashCode ^
      level.hashCode ^
      amount.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      vaccine.hashCode ^
      vacsite.hashCode;
  }


  static Future<List<VacsiteStorage>> fetchSearchVaccineWhereVacsite({required int vaccineId}) async {
    try {
      final response = await http.get(Uri.parse(url + '/vaccinesitestorage/$vaccineId'),
          headers: {'Authorization': token});
      if (response.statusCode == 200) {
        return json
            .decode(response.body)['vacsites']
            .cast<Map<String, dynamic>>()
            .map<VacsiteStorage>((data) => VacsiteStorage.fromMap(data))
            .toList();
      } else {
        throw FetchDataException(error: response.body);
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
