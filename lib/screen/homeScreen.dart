import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regisapp/component/component.dart';
import 'package:regisapp/style/color.dart';
import 'package:regisapp/style/textstyle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int _curIndex = 0;
  final carousContext = CarouselController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
           _buildSlider(),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0), child: _buildHome()),
            )
          ],
        ),
      ),
    );
  }
Widget _buildSlider() {
    return InkWell(
     
      child: CarouselSlider(
          carouselController: carousContext,
          options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlayAnimationDuration: const Duration(seconds: 2),
              onPageChanged: (index, reason) {
                setState(() {
              
                });
              }), items: [SvgPicture.asset(
                      'assets/images/no_promotion.svg',
                      height: 200,
                      fit: BoxFit.cover,
                    )],
         ),
    );
  }
  Widget _buildHome() {
    return GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: [
          Component(
              child: InkWell(
                  focusColor: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.widgets, size: 40),
                        Center(
                            child: Text("ຈັດການຂໍ້ມູນ", style: bodyText2Bold))
                      ]))),
          Component(
              child: InkWell(
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
                  focusColor: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.mark_unread_chat_alt, size: 40),
                        Center(
                            child: Text(
                          "ນັດໝາຍສັກວັກຊີນ",
                          textAlign: TextAlign.center,
                          style: bodyText2Bold,
                        ))
                      ]))),
                       Component(
              child: InkWell(
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
