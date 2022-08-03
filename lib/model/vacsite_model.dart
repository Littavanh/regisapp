// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:regisapp/source/exception.dart';
import 'package:regisapp/source/source.dart';

class VacsiteModel {
final int? id;
 final int provinceId;
 final String name;
 final String? vaccsitestatus;
 final String? isDelete;
 final String? createdAt;
final  String? updatedAt;
  VacsiteModel({
    this.id,
    required this.provinceId,
    required this.name,
    this.vaccsitestatus,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });
 

  VacsiteModel copyWith({
    int? id,
    int? provinceId,
    String? name,
    String? vaccsitestatus,
    String? isDelete,
    String? createdAt,
    String? updatedAt,
  }) {
    return VacsiteModel(
      id: id ?? this.id,
      provinceId: provinceId ?? this.provinceId,
      name: name ?? this.name,
      vaccsitestatus: vaccsitestatus ?? this.vaccsitestatus,
      isDelete: isDelete ?? this.isDelete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'provinceId': provinceId,
      'name': name,
      'vaccsitestatus': vaccsitestatus,
      'isDelete': isDelete,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory VacsiteModel.fromMap(Map<String, dynamic> map) {
    return VacsiteModel(
      id: map['id'] != null ? map['id'] as int : null,
      provinceId: map['provinceId'] as int,
      name: map['name'] as String,
      vaccsitestatus: map['vaccsitestatus'] != null ? map['vaccsitestatus'] as String : null,
      isDelete: map['isDelete'] != null ? map['isDelete'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VacsiteModel.fromJson(String source) => VacsiteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VacsiteModel(id: $id, provinceId: $provinceId, name: $name, vaccsitestatus: $vaccsitestatus, isDelete: $isDelete, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant VacsiteModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.provinceId == provinceId &&
      other.name == name &&
      other.vaccsitestatus == vaccsitestatus &&
      other.isDelete == isDelete &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      provinceId.hashCode ^
      name.hashCode ^
      vaccsitestatus.hashCode ^
      isDelete.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }

 static Future<List<VacsiteModel>> fetchVacsiteById(
      {required int provinceId}) async {
    try {
      final response = await http.get(Uri.parse(url + '/vaccinationsites/available/$provinceId'),
          headers: {'Authorization': token});
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['vacsites']
            .cast<Map<String, dynamic>>()
            .map<VacsiteModel>((data) => VacsiteModel.fromMap(data))
            .toList();
      } else {
        throw FetchDataException(error: response.body);
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }

}

