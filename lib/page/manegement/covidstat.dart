import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CovidStatistic extends StatefulWidget {
  const CovidStatistic({Key? key}) : super(key: key);

  @override
  State<CovidStatistic> createState() => _CovidStatisticState();
}

class _CovidStatisticState extends State<CovidStatistic> {

  @override

   
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text("ສະຖິຕິໂຄວິດ"),
        ));
  }
}
