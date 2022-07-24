import 'package:regisapp/model/reserve_model.dart';
import 'package:regisapp/notification/socket/socket_controller.dart';
import 'package:regisapp/provider/bloc/notification_bloc.dart';
import 'package:regisapp/provider/event/notification_event.dart';
import 'package:regisapp/provider/state/notification_state.dart';
import 'package:regisapp/source/source.dart';
import 'package:regisapp/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerNotification extends StatefulWidget {
  const CustomerNotification({Key? key}) : super(key: key);

  @override
  State<CustomerNotification> createState() => _CustomerNotificationState();
}

class _CustomerNotificationState extends State<CustomerNotification> {
  ReserveModel? detail;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 0));
    context.read<NotificationBloc>().add(FetchMemberNotification());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return SizedBox(
              width: size.width,
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Builder(builder: (context) {
                        if (state is NotificationLoadCompleteState) {
                           if (state.reserve != null) {
                            // for (var item in state.reserve!.reserveDetail!) {
                            //   detail = item;
                            // }

                            print(state.reserve!.date);
                
                            return Card(
                              child: ListTile(
                                leading: const CircleAvatar(
                                    radius: 20,
                                    child:
                                        Icon(Icons.notifications_active_rounded)),
                                title: const Text('ແຈ້ງເຕືອນການນັດໝາຍ'),
                                subtitle: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                          'ວັນທີ: ${fmdate.format(DateTime.parse(detail != null ? detail!.date : state.reserve!.date))}'),
                                    ),
                                    const SizedBox(width: 20),
                                  // Flexible(
                                  //     child: Text(
                                  //         'ສະຖານທີ່: ${state.reserve!.vaccinationSiteId}'),
                                  //   ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return _isStateEmty();
                          }
                        } else {
                          return _isStateEmty();
                        }
                      })
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget _isStateEmty({String? message}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => _onRefresh(),
              icon: const Icon(Icons.sync_rounded,
                  size: 30, color: primaryColor)),
          const SizedBox(
            width: 10,
          ),
          Text(message ?? 'ບໍ່ມີຂໍ້ມູນ'),
        ],
      )),
    );
  }
}
