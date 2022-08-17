// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:regisapp/source/exception.dart';
import 'package:regisapp/source/source.dart';

class VaccineModel {
   int id;
    String name;
    String? vaccinetype;
    String? isDelete;
    String? createdAt;
    String? updatedAt;
  VaccineModel({
    required this.id,
    required this.name,
    this.vaccinetype,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });
 
 

 

 

  VaccineModel copyWith({
    int? id,
    String? name,
    String? vaccinetype,
    String? isDelete,
    String? createdAt,
    String? updatedAt,
  }) {
    return VaccineModel(
      id: id ?? this.id,
      name: name ?? this.name,
      vaccinetype: vaccinetype ?? this.vaccinetype,
      isDelete: isDelete ?? this.isDelete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'vaccinetype': vaccinetype,
      'isDelete': isDelete,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory VaccineModel.fromMap(Map<String, dynamic> map) {
    return VaccineModel(
      id: map['id'] as int,
      name: map['name'] as String,
      vaccinetype: map['vaccinetype'] != null ? map['vaccinetype'] as String : null,
      isDelete: map['isDelete'] != null ? map['isDelete'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VaccineModel.fromJson(String source) => VaccineModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VaccineModel(id: $id, name: $name, vaccinetype: $vaccinetype, isDelete: $isDelete, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant VaccineModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.vaccinetype == vaccinetype &&
      other.isDelete == isDelete &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      vaccinetype.hashCode ^
      isDelete.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
  static Future<List<VaccineModel>> fetchAllVaccine() async {
    try {
      final response = await http.get(Uri.parse(url + '/vaccines/'),
          headers: {'Authorization': token});
      if (response.statusCode == 200) {
        return json
            .decode(response.body)['vaccines']
            .cast<Map<String, dynamic>>()
            .map<VaccineModel>((data) => VaccineModel.fromMap(data))
            .toList();
      } else {
        throw FetchDataException(error: response.body);
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }
   static Future<List<VaccineModel>> fetchVaccine({required int vacsiteId}) async {
    try {
      final response = await http.get(Uri.parse(url + '/vaccines/$vacsiteId'),
          headers: {'Authorization': token});
      if (response.statusCode == 200) {
        return json
            .decode(response.body)['vaccines']
            .cast<Map<String, dynamic>>()
            .map<VaccineModel>((data) => VaccineModel.fromMap(data))
            .toList();
      } else {
        throw FetchDataException(error: response.body);
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }

 
}
