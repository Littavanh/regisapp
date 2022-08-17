import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:regisapp/model/reserve_model.dart';
import 'package:regisapp/notification/socket/socket_controller.dart';
import 'package:regisapp/provider/bloc/notification_bloc.dart';
import 'package:regisapp/provider/event/notification_event.dart';
import 'package:regisapp/provider/state/notification_state.dart';
import 'package:regisapp/source/source.dart';
import 'package:regisapp/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regisapp/style/textstyle.dart';

import '../model/post_model.dart';
import '../page/postdetail_page.dart';
import '../provider/bloc/post_bloc.dart';
import '../provider/event/post_event.dart';
import '../provider/notification_provider.dart';
import '../provider/state/post_state.dart';

class CustomerNotification extends StatefulWidget {
  const CustomerNotification({Key? key}) : super(key: key);

  @override
  State<CustomerNotification> createState() => _CustomerNotificationState();
}

class _CustomerNotificationState extends State<CustomerNotification> {
  int _curIndex = 0;
  final carousContext = CarouselController();
  ReserveModel? detail;
 Future<void> _onPostRefresh() async {
    Future.delayed(const Duration(seconds: 0));
    context.read<PostBloc>().add(FetchPost());
  }
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 0));
    context.read<NotificationBloc>().add(FetchMemberNotification());
  }
 @override
void initState() {
    SocketController.socket.on('notifi_msg', (data) {
      if (isAdmin || isEmployee) {
        _onRefresh();
        _onPostRefresh();
      }
    });
_onPostRefresh();
    _onRefresh();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Consumer<NotificationManager>(builder: (context, value, child) {
      return BlocBuilder<PostBloc, PostState>(
        builder: (_, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(children: [Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0), child: _buildHome()),
                ),
                const SizedBox(height: 10),
                Container(
                   padding: const EdgeInsets.only(bottom: 10),
                    height: 200,
                    width: size.width,
                    color: Colors.white60,
                    child: GridTile(
                      child: Builder(builder: (_) {
                        if (state is PostLoadCompleteState) {
                          return _buildSlider(state.posts);
                        } else if (state is PostLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Center(
                              child:
                                  Text('ບໍ່ມີຂ່່າວສານ', style: bodyText2Bold));
                        }
                      }),
                    )),
                
                
              ]),
            ),
          );
        },
      );
    });
 
  }
  _buildHome(){
   Size size = MediaQuery.of(context).size;
    return BlocBuilder<NotificationBloc, NotificationState>(
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

                            // print(state.reserve!.date);
                
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
      );
     
  
  }
 Widget _buildSlider(List<PostModel> posts) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PostDetailPage(post: posts[_curIndex])));
      },
      child: CarouselSlider(
          carouselController: carousContext,
          options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(seconds: 2),
              onPageChanged: (index, reason) {
                setState(() {
                  _curIndex = index;
                  context
                      .read<NotificationManager>()
                      .setpostTitle(title: posts[_curIndex].name);
                });
              }),
          items: posts
              .map((e) => (e.image!.isEmpty)
                  ? SvgPicture.asset(
                      'assets/images/no_promotion.svg',
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: urlImg + '/${e.image}',
                      fit: BoxFit.fill,
                    ))
              .toList()),
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
