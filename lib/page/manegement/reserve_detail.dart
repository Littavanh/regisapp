import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:regisapp/style/color.dart';
import 'package:regisapp/style/textstyle.dart';

import '../../alert/progress.dart';
import '../../component/component.dart';
import '../../controller/custombutton.dart';
import '../../model/reserve_model.dart';
import '../../provider/bloc/reserve_bloc.dart';
import '../../provider/event/reserve_event.dart';
import '../../provider/state/reserve_state.dart';

class Reserve_Detail extends StatefulWidget {
  const Reserve_Detail({ Key? key }) : super(key: key);

  @override
  State<Reserve_Detail> createState() => _Reserve_DetailState();
}

class _Reserve_DetailState extends State<Reserve_Detail> {
   Future<void> _onRefresh() async {
    Future.delayed(const Duration(seconds: 0));
    context.read<ReserveBloc>().add(FetchUserPending());
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("ນັດໝາຍການສັກວັກຊີນ"),
        // actions: [
        //   IconButton(
        //       onPressed: () => Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (_) =>
        //                 const PostFormEditor(title: 'ເພີ່ມ', edit: false),
        //           )),
        //       icon: const Icon(Icons.add_circle_outline))
        // ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<ReserveBloc, ReserveState>(
            builder: (context, state) {
              if (state is ReserveInitialState) {
                _onRefresh();
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ReserveLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ReserveLoadCompleteState) {
                if (state.reserves.isEmpty) return _isStateEmty();
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                      itemCount: state.reserves.length,
                      itemBuilder: (_, index) {
                        return buildCard(state.reserves[index]);
                      }
                      
                      ),
                );
              }

              if (state is ReserveErrorState) {
                return _isStateEmty(message: state.error);
              } else {
                return _isStateEmty();
              }
            },
          )),
    );
  }
Widget buildCard(ReserveModel reserve) {
    return InkWell( 
      child: Component(
        
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(top: 12),
        child: Container(
          
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ວັນທີສັກ: ${reserve.date}", style: bodyText2Bold),
                    Text('ລາຍລະອຽດ: ເຂັມທີ ${reserve.level}, ${reserve.vaccineId}, ສູນ ${reserve.vaccinationSiteId} ',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
    
              const Spacer(),
              Column(
                children: [
                
            
                  DeleteButton(onPressed: () {
                    showQuestionDialog(
                            context: context,
                            title: 'ຍົກເລີກ',
                            content: "ຕ້ອງການຍົກເລີກການຈອງແທ້ບໍ?")
                        .then((value) {
                      if (value != null && value) {
                        // onDelete(reserve.id ?? 0);
                      }
                    });
                  })
                ],
              ),
            ],
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
        Text(message ?? 'ບໍ່ມີຂໍ້ມູນ'),
      ],
    ));
  }
  void onDelete(ReserveModel reserve,int id) async {
    myProgress(context, null);
    await ReserveModel.cancelReserve(id: id, data: reserve).then((delete) {
      if (delete.code == 200) {
        Navigator.pop(context);
        showCompletedDialog(
                context: context, title: 'ຍົກເລີກ', content: 'ຍົກເລີກສຳເລັດແລ້ວ')
            .then((value) => _onRefresh());
      } else {
        Navigator.pop(context);
        showFailDialog(
            context: context,
            title: 'ຍົກເລີກ',
            content: delete.error ?? 'ຍົກເລີກບໍ່ສຳເລັດ');
      }
    }).catchError((onError) {
      Navigator.pop(context);
      showFailDialog(
          context: context, title: 'ຍົກເລີກ', content: onError.toString());
    });
  }
}