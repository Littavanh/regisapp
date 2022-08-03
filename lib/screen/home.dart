import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:regisapp/component/component.dart';
import 'package:regisapp/model/post_model.dart';
import 'package:regisapp/notification/customer_notification.dart';
import 'package:regisapp/page/manegement/covidstat.dart';
import 'package:regisapp/page/manegement/noti.dart';
import 'package:regisapp/page/manegement/post.dart';
import 'package:regisapp/page/manegement/register.dart';
import 'package:regisapp/page/manegement/reserve_detail.dart';
import 'package:regisapp/page/manegement/reserve_history.dart';
import 'package:regisapp/page/postdetail_page.dart';
import 'package:regisapp/page/register.dart';
import 'package:regisapp/page/register_page.dart';
import 'package:regisapp/provider/bloc/notification_bloc.dart';
import 'package:regisapp/provider/bloc/post_bloc.dart';
import 'package:regisapp/provider/bloc/reserve_bloc.dart';
import 'package:regisapp/provider/event/notification_event.dart';
import 'package:regisapp/provider/event/post_event.dart';
import 'package:regisapp/provider/event/reserve_event.dart';
import 'package:regisapp/provider/state/post_state.dart';
import 'package:regisapp/source/source.dart';
import 'package:regisapp/style/color.dart';
import 'package:regisapp/style/textstyle.dart';

import '../provider/notification_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _curIndex = 0;
  final carousContext = CarouselController();
  Future<void> _onRefresh() async {
    Future.delayed(const Duration(seconds: 0));
    context.read<PostBloc>().add(FetchPost());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onRefresh();
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
              child: Column(children: [
                Container(
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
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0), child: _buildHome()),
                )
              ]),
            ),
          );
        },
      );
    });
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

  Widget _buildHome() {
    return GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: [
          Component(
              child: InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const PostPage())),
                  focusColor: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.feed, size: 40),
                        Center(
                            child: Text(
                          "ຂ່າວສານ",
                          textAlign: TextAlign.center,
                          style: bodyText2Bold,
                        ))
                      ]))),
          Component(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CovidStatistic()));
                          
                  },
                  focusColor: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.equalizer, size: 40),
                        Center(
                            child: Text(
                          "ສະຖິຕິໂຄວິດ",
                          textAlign: TextAlign.center,
                          style: bodyText2Bold,
                        ))
                      ]))),
          Component(
              child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterCovidPage())),
                  focusColor: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.app_registration, size: 40),
                        Center(
                            child: Text(
                          "ລົງທະບຽນສັກວັກຊີນ",
                          textAlign: TextAlign.center,
                          style: bodyText2Bold,
                        ))
                      ]))),
          Component(
              child: InkWell(
                  onTap: () async {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ReserveDetails()));
                          context.read<ReserveBloc>().add(FetchUserPending());
                  },
                  focusColor: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.pending_actions, size: 40),
                        Center(
                            child: Text(
                          "ນັດໝາຍສັກວັກຊີນ",
                          textAlign: TextAlign.center,
                          style: bodyText2Bold,
                        ))
                      ]))),
          Component(
              child: InkWell(
                  onTap: () async{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Reserve_History()));
                            context.read<ReserveBloc>().add(FetchUserComplete());
                  },
                  focusColor: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.history, size: 40),
                        Center(
                            child: Text(
                          "ປະຫວັດການສັກວັກຊີນ",
                          textAlign: TextAlign.center,
                          style: bodyText2Bold,
                        ))
                      ]))),
        ]);
  }
}
