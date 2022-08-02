import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:regisapp/notification/customer_notification.dart';
import 'package:regisapp/notification/socket/socket_controller.dart';
import 'package:regisapp/page/edit_profile_page.dart';
import 'package:regisapp/page/login_page.dart';
import 'package:regisapp/page/postlist.dart';
import 'package:regisapp/page/register_page.dart';
import 'package:regisapp/provider/bloc/notification_bloc.dart';
import 'package:regisapp/provider/bloc/post_bloc.dart';
import 'package:regisapp/provider/event/notification_event.dart';
import 'package:regisapp/provider/event/post_event.dart';
import 'package:regisapp/provider/state/notification_state.dart';
import 'package:regisapp/screen/home.dart';
import 'package:regisapp/page/register.dart';
import 'package:regisapp/source/source.dart';
import 'package:regisapp/storage/storage.dart';

import 'package:regisapp/style/color.dart';

import '../provider/notification_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cusmtomerWidgets = <Widget>[
    const HomeScreen(),
    const RegisScreen(),
    const CustomerNotification(),
    const EditProfilePage(),
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    SocketController.initialSocket();

    // SocketController.socket
    //     .on("message", (data) => stream.socketRespone.sink.add(data));

    SocketController.socket.on("notifi_msg", (data) {
      if (isAdmin || isEmployee) {
        _onRefreshAllNotifications();
      } else {
        _onRefreshMemberNotifications();
      }
    });

    if (isAdmin || isEmployee) {
      _onRefreshAllNotifications();
    } else {
      _onRefreshMemberNotifications();
    }
    super.initState();
  }

  @override
  dispose() {
    // stream.dispose();
    SocketController.disconnect();
    super.dispose();
  }

  Future<void> _onRefreshMemberNotifications() async {
    await Future.delayed(const Duration(seconds: 0));
    context.read<NotificationBloc>().add(FetchMemberNotification());
  }

  Future<void> _onRefreshAllNotifications() async {
    await Future.delayed(const Duration(seconds: 0));
    context.read<NotificationBloc>().add(FetchAllNotification());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationManager>(
      builder: (context, values, child) {
        final cusmtomerItems = <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'ໜ້າຫຼັກ'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.menu_open_rounded), label: 'ລົງທະບຽນ'),
          BottomNavigationBarItem(
              icon: values.adminNotifi == ''
                  ? const Icon(Icons.notifications_active_rounded)
                  : Badge(
                      child: const Icon(Icons.notifications_active_rounded),
                      badgeColor: Colors.red,
                      badgeContent: Text(
                        values.adminNotifi,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
              label: 'ແຈ້ງເຕືອນ'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'ເພີ່ມເຕີມ'),
        ];

        return BlocBuilder<NotificationBloc, NotificationState>(
          builder: (_, state) {
            if (state is NotificationLoadCompleteState) {
              if (state.reserve != null) {
                Future.delayed(const Duration(seconds: 0)).then((value) =>
                    context
                        .read<NotificationManager>()
                        .setAdminNotifi(notifi: '1'));
              } else {
                Future.delayed(const Duration(seconds: 0)).then((value) =>
                    context
                        .read<NotificationManager>()
                        .setAdminNotifi(notifi: ''));
              }
            }

            if (state is AllNotificationLoadCompleteState) {
              if (state.reserves.isNotEmpty) {
                Future.delayed(const Duration(seconds: 0)).then((value) =>
                    context
                        .read<NotificationManager>()
                        .setAdminNotifi(notifi: '${state.reserves.length}'));
              } else {
                Future.delayed(const Duration(seconds: 0)).then((value) =>
                    context
                        .read<NotificationManager>()
                        .setAdminNotifi(notifi: ''));
              }
            }

            if (state is NotificationErrorState) {
              Future.delayed(const Duration(seconds: 0)).then((value) => context
                  .read<NotificationManager>()
                  .setAdminNotifi(notifi: ''));

              Future.delayed(const Duration(seconds: 0)).then((value) => context
                  .read<NotificationManager>()
                  .setAdminNotifi(notifi: ''));
            }

            return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: AppBar(
                  title: const Text('REGISTER COVID APP'),
                  actions: [
                    IconButton(
                        onPressed: () async {
                          final remeber = RememberMe(
                              username: '', password: '', remember: false);
                          await remeber.setUser();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()));
                        },
                        tooltip: 'ອອກຈາກລະບົບ',
                        icon: const Icon(Icons.settings_power_outlined,
                            color: iconColor)),
                  ],
                ),
                body: cusmtomerWidgets[_currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: primaryColor,
                    currentIndex: _currentIndex,
                    items: cusmtomerItems,
                    onTap: (int index) => setState(() {
                          _currentIndex = index;
                        })));
          },
        );
      },
    );
  }
}
