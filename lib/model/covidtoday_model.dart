import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:regisapp/source/exception.dart';
class CovidTodayModel {
  int? infected;
  String? tested;
  int? recovered;
  int? deceased;
  String? country;
  String? moreData;
  String? historyData;
  String? sourceUrl;
  String? lastUpdatedApify;

  CovidTodayModel(
      {this.infected,
      this.tested,
      this.recovered,
      this.deceased,
      this.country,
      this.moreData,
      this.historyData,
      this.sourceUrl,
      this.lastUpdatedApify});

  CovidTodayModel.fromJson(Map<String, dynamic> json) {
    infected = json['infected'];
    tested = json['tested'];
    recovered = json['recovered'];
    deceased = json['deceased'];
    country = json['country'];
    moreData = json['moreData'];
    historyData = json['historyData'];
    sourceUrl = json['sourceUrl'];
    lastUpdatedApify = json['lastUpdatedApify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infected'] = this.infected;
    data['tested'] = this.tested;
    data['recovered'] = this.recovered;
    data['deceased'] = this.deceased;
    data['country'] = this.country;
    data['moreData'] = this.moreData;
    data['historyData'] = this.historyData;
    data['sourceUrl'] = this.sourceUrl;
    data['lastUpdatedApify'] = this.lastUpdatedApify;
    return data;
  }
  
}
