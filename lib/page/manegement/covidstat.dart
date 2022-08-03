import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:regisapp/model/covidtoday_model.dart';
import 'package:regisapp/source/exception.dart';
import 'package:regisapp/style/color.dart';

import '../../component/component.dart';

class CovidStatistic extends StatefulWidget {
  const CovidStatistic({Key? key}) : super(key: key);

  @override
  State<CovidStatistic> createState() => _CovidStatisticState();
}

class _CovidStatisticState extends State<CovidStatistic> {
  List _datafromAPI = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCovid();
  }

  Future<void> fetchCovid() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true'));
    final data = json.decode(response.body);
    setState(() {
      _datafromAPI = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title:  Text("ສະຖິຕິໂຄວິດ ປະຈຳວັນທີ ${DateTime.now()}"),
        ),
        body: SafeArea(
          child: _datafromAPI.isEmpty
              // ignore: prefer_const_constructors
              ? Center(child: const CircularProgressIndicator())
              // The ListView that displays photos
              : Component(
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.only(top: 6),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    width: double.infinity,
                    child: ListView.separated(
                      itemCount: _datafromAPI.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ListTile(
                          leading:
                              const CircleAvatar(backgroundImage: AssetImage("assets/images/cc.png")),
                          title: Text(
                            'ປະເທດ ${_datafromAPI[index]['country']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                              'ຫາຍດີ: ${_datafromAPI[index]["recovered"]}'),
                          trailing: Text(
                              'ຕິດເຊື້ອ: ${_datafromAPI[index]["infected"]}'),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 2,
                          color: primaryColor,
                        );
                      },
                    ),
                  ),
                ),
          // ListView.builder(
          //     itemCount: _datafromAPI.length,
          //     itemBuilder: (BuildContext ctx, index) {
          //       return ListTile(
          //         title: Text(_datafromAPI[index]['country']),
          //         subtitle:
          //             Text('ຕິດເຊື້ອ: ${_datafromAPI[index]["infected"]}'),
          //       );
          //     },
          //   ),
        ));
  }
}
