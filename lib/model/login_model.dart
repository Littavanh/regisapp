import 'dart:convert';
import 'dart:io';
import 'package:regisapp/source/exception.dart';
import 'package:regisapp/source/source.dart';
import 'package:http/http.dart' as http;

class LoginModel {
  final String? id;
  final String phone;
  final String? firstname;
  final String? lastname;
  final String? password;
  final List<String>? roles;
  final String? accessToken;
  final String? image;
  LoginModel(
      {this.id,
      required this.phone,
      this.firstname,
      this.password,
      this.lastname,
      this.roles,
      this.accessToken,
      this.image});

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'password': password,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      id: map['id'] ?? '',
      phone: map['phone'] ?? '',
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      roles: List<String>.from(map['roles']),
      accessToken: map['accessToken'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));

  static Future<LoginModel> login({required LoginModel data}) async {
    try {
      final response = await http.post(Uri.parse(url + '/login'),
          headers: {'Content-Type': 'application/json'}, body: data.toJson());
      if (response.statusCode == 200) {
        final user = LoginModel.fromJson(response.body);
        token = 'Bearer ${user.accessToken}';
        userId = user.id ?? '';
        userFName = user.firstname ?? '';
        userLName = user.lastname ?? '';
        userImage = user.image ?? '';
        for (var item in user.roles!) {
          if (item == 'superadmin') {
            isAdmin = true;
            break;
          } else if (item == 'employee') {
            isAdmin = false;
            isEmployee = true;
          } else if (item == 'customer') {
            isCustomer = true;
            break;
          }
        }
        return user;
      } else {
        throw FetchDataException(error: response.body);
      }
    } on SocketException {
      throw 'ບໍ່ສາມາດເຊື່ອຕໍ່ Server';
    }
  }
}
