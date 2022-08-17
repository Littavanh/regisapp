import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:regisapp/model/vaccine_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:regisapp/model/vacsiteStorage_model.dart';
import 'package:regisapp/page/manegement/register.dart';
import 'package:regisapp/provider/event/vacsite_storage_event.dart';
import 'package:regisapp/provider/state/vacsite_storage_state.dart';


import 'package:regisapp/source/source.dart';

import '../../../component/component.dart';
import '../../../provider/bloc/vacsite_storage_bloc.dart';
import '../../../style/color.dart';
import '../../../style/textstyle.dart';

class SearchVaccineForm extends StatefulWidget {
  const SearchVaccineForm({ Key? key,  required this.vaccine }) : super(key: key);
  final VaccineModel vaccine;

  @override
  State<SearchVaccineForm> createState() => _SearchVaccineFormState();
}

class _SearchVaccineFormState extends State<SearchVaccineForm> {
  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  Future<void> _onRefresh() async {
    Future.delayed(const Duration(seconds: 0));
    context.read<VacsiteStorageBloc>().add(FetchSearchVaccineWhereVacsite(vaccineId: widget.vaccine.id));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Text(widget.vaccine.name),),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<VacsiteStorageBloc, VacsiteStorageState>(
            builder: (context, state) {
              if (state is VacsiteStorageInitialState) {
                _onRefresh();
                return const Center(child: CircularProgressIndicator());
              }

              if (state is VacsiteStorageLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is VacsiteStorageLoadCompleteState) {
                if (state.vacsiteStorages.isEmpty) return _isStateEmty();
                return ListView.builder(
                    itemCount: state.vacsiteStorages.length,
                    itemBuilder: (_, index) {
                      return _buildCard(state.vacsiteStorages[index]);
                    });
              }

              if (state is VacsiteStorageErrorState) {
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
            onPressed: () => _onRefresh(),
            icon:
                const Icon(Icons.sync_rounded, size: 30, color: primaryColor)),
        const SizedBox(
          width: 10,
        ),
        Text(message ?? 'ບໍ່ມີສະຖານທີ່ທີ່ມັກວັກຊີນນີ້'),
      ],
    ));}

  Widget _buildCard(VacsiteStorage data) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      // onTap: () => Navigator.push(context,
      //     MaterialPageRoute(builder: (_) => PostDetailPage(post: data))),
      child: Component(
          height: 100,
          padding: EdgeInsets.zero,
          
          borderRadius: BorderRadius.circular(5),
          child: ListView(children: [ ListTile(
                          leading:
                              const CircleAvatar(backgroundImage: AssetImage("assets/images/map.webp")),
                          title: Text(
                            data.vacsite!.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                             'ເຂັມທີ : ${ data.level.toString()}'),
                          trailing: Text(
                            'ຈຳນວນເຫຼືອ : ${ data.amount.toString()}'),
                        ),],)
          ),
    );
  }
}
