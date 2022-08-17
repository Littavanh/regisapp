import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regisapp/alert/progress.dart';
import 'package:regisapp/component/component.dart';
import 'package:regisapp/controller/custombutton.dart';
import 'package:regisapp/model/reserve_model.dart';
import 'package:regisapp/notification/socket/socket_controller.dart';
import 'package:regisapp/provider/bloc/reserve_bloc.dart';
import 'package:regisapp/provider/event/reserve_event.dart';
import 'package:regisapp/provider/state/reserve_state.dart';
import 'package:regisapp/source/source.dart';
import 'package:regisapp/style/color.dart';
import 'package:regisapp/style/textstyle.dart';

class ReserveDetails extends StatefulWidget {
  const ReserveDetails({Key? key}) : super(key: key);

  @override
  State<ReserveDetails> createState() => _ReserveDetailsState();
}

class _ReserveDetailsState extends State<ReserveDetails> {
  Future<void> _onRefresh() async {
    Future.delayed(const Duration(seconds: 0));
    context.read<ReserveBloc>().add(FetchUserPending());
  }

  @override
  void initState() {
    SocketController.socket.on('notifi_msg', (data) {
      if (isAdmin || isEmployee) {
        _onRefresh();
      }
    });

    _onRefresh();
    super.initState();
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
                      }),
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
                    const Divider(
                      color: primaryColor,
                    ),
                    const Text("ລາຍລະອຽດ: ", style: bodyText2Bold),
                    Text('*ເຂັມທີ ${reserve.level}',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    Text('*ຊະນິດວັກຊີນ ${reserve.vaccine!.name}',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    Text('*ສະຖານທີ່ສັກ ${reserve.vacsite!.name}',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Column(
                children: [
                  ConfirmButton(onPressed: () {
                    showQuestionDialog(
                            context: context,
                            title: 'ຢືນຢັນ',
                            content: "ຢືນຢັນວ່າໄດ້ສັກວັກຊີນແລ້ວ")
                        .then((value) {
                      if (value != null && value) {
                        _completeReserve(reserve);
                      }
                    });
                  }),
                  const SizedBox(height: 5,),
                  DeleteButton(onPressed: () {
                    showQuestionDialog(
                            context: context,
                            title: 'ຍົກເລີກ',
                            content: "ຕ້ອງການຍົກເລີກການຈອງແທ້ບໍ?")
                        .then((value) {
                      if (value != null && value) {
                        _cancelReserve(reserve);
                      }
                    });
                  }),
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

  void _cancelReserve(ReserveModel data) async {
    myProgress(context, null);
    await ReserveModel.cancelReserve(
            id: data.id ?? 0,
            vaccineId: data.vaccineId ?? 0,
            vaccinationSiteId: data.vaccinationSiteId ?? 0,
            level: data.level)
        .then((value) {
      if (value.code == 200) {
        Navigator.pop(context);

        showCompletedDialog(
                context: context,
                title: 'ຍົກເລີກ',
                content: "ຍົກເລີກການຈອງສຳເລັດແລ້ວ")
            .then((value) => _onRefresh());
      } else {
        Navigator.pop(context);
        showFailDialog(
            context: context,
            title: 'ຍົກເລີກ',
            content: "ຍົກເລີກການຈອງບໍ່ສຳເລັດ");
      }
    }).catchError((e) {
      Navigator.pop(context);
      showFailDialog(context: context, title: 'ຍົກເລີກ', content: e.toString());
    });
  }

  void _completeReserve(ReserveModel data) async {
    myProgress(context, null);
    await ReserveModel.completeReserve(id: data.id ?? 0).then((value) {
      if (value.code == 200) {
        Navigator.pop(context);

        showCompletedDialog(
                context: context,
                title: 'ຢືນຢັນ',
                content: "ທ່ານສັກວັກຊີນສຳເລັດແລ້ວ")
            .then((value) => _onRefresh());
      } else {
        Navigator.pop(context);
        showFailDialog(
            context: context,
            title: 'ຢືນຢັນ',
            content: "ທ່ານສັກວັກຊີນສຳເລັດແລ້ວ");
      }
    }).catchError((e) {
      Navigator.pop(context);
      showFailDialog(context: context, title: 'ຢືນຢັນ', content: e.toString());
    });
  }
}
