import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:regisapp/page/manegement/form/search_vaccine_form.dart';
import 'package:regisapp/provider/event/vaccine_event.dart';

import 'package:regisapp/source/exception.dart';
import 'package:regisapp/source/source.dart';

import '../../component/component.dart';
import '../../model/vaccine_model.dart';
import '../../provider/bloc/vaccine_bloc.dart';
import '../../provider/state/vaccine_state.dart';
import '../../style/color.dart';
import '../../style/textstyle.dart';

class SearchVaccine extends StatefulWidget {
  const SearchVaccine({Key? key}) : super(key: key);

  @override
  State<SearchVaccine> createState() => _SearchVaccineState();
}

class _SearchVaccineState extends State<SearchVaccine> {
  List _datafromAPI = [];
  @override
  void initState() {
    super.initState();
    fetchAllVaccine();
  }

  // Future<void> fetchAllVaccine() async {
  //   final response = await http.get(Uri.parse(url + '/vaccines/'));
  //   final data = json.decode(response.body)['vaccines'];
  //   setState(() {
  //     _datafromAPI = data;
  //   });
  // }
  Future<void> fetchAllVaccine() async {
    Future.delayed(const Duration(seconds: 0));
    context.read<VaccineBloc>().add(FetchAllVaccine());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ຄົ້ນຫາວັກຊີນຕາມສະຖານທີ່ຕ່າງໆ"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: RefreshIndicator(
          onRefresh: fetchAllVaccine,
          child: BlocBuilder<VaccineBloc, VaccineState>(
            builder: (context, state) {
              if (state is VaccineInitialState) {
                fetchAllVaccine();
                return const Center(child: CircularProgressIndicator());
              }

              if (state is VaccineLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is VaccineLoadCompleteState) {
                if (state.vaccines.isEmpty) return _isStateEmty();
                return GridView.builder(
                  itemCount: state.vaccines.length,
                  itemBuilder: (_, index) {
                    return _buildHome(state.vaccines[index]);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                );
              }

              if (state is VaccineErrorState) {
                return _isStateEmty();
              } else {
                return _isStateEmty();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _isStateEmty({String? message}) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () => fetchAllVaccine(),
            icon:
                const Icon(Icons.sync_rounded, size: 30, color: primaryColor)),
        const SizedBox(
          width: 10,
        ),
        Text(message ?? 'ບໍ່ມີວັກຊີນ'),
      ],
    ));
  }

  Widget _buildHome(VaccineModel data) {
    return Component(
        child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SearchVaccineForm(vaccine: data))),
            focusColor: primaryColor,
            borderRadius: BorderRadius.circular(10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.vaccines, size: 40),
              Center(
                  child: Text(
                data.name,
                textAlign: TextAlign.center,
                style: bodyText2Bold,
              ))
            ])));
  }
}
