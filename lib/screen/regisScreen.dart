import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regisapp/controller/customcontainer.dart';

class RegisScreen extends StatefulWidget {
  const RegisScreen({ Key? key }) : super(key: key);

  @override
  State<RegisScreen> createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
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
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child:
                    SvgPicture.asset("assets/images/no_promotion.svg", height: 150),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                    // height: 10,
                    child: Text("ການລົງທະບຽນລ່ວງໜ້າສຳລັບກາຮັບວັກຊີນກັນພະຍາດໂຄວິດ-19",
                        style: Theme.of(context).textTheme.headline1)),
              ),
              
              Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 28),
                  child: ElevatedButton(
                      onPressed: () {
                      
                      },
                      child: const Text("ລົງທະບຽນ")))
          ],
        ),
      ),
    );
  }
  
}