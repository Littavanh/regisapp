import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisapp/page/home.dart';

import 'package:regisapp/style/color.dart';
import 'package:regisapp/style/size.dart';
import 'package:regisapp/style/textstyle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
                primarySwatch: themeColor,
                fontFamily: 'NotoSansLao',
                appBarTheme: AppBarTheme(
                  elevation: 0,
                  backgroundColor: themeColor,
                  titleTextStyle:
                      GoogleFonts.notoSansLao(textStyle: appBarText),
                ),
                primaryIconTheme:
                    const IconThemeData(color: primaryColor, size: iconSize),
                iconTheme:
                    const IconThemeData(color: primaryColor, size: iconSize),
                textTheme: TextTheme(
                    bodyText1: GoogleFonts.notoSansLao(textStyle: bodyText1),
                    bodyText2: GoogleFonts.notoSansLao(textStyle: bodyText2),
                    headline1: GoogleFonts.notoSansLao(textStyle: header1Text),
                    subtitle1: GoogleFonts.notoSansLao(textStyle: subTitle1)),
                primaryTextTheme: TextTheme(
                    bodyText1: GoogleFonts.notoSansLao(textStyle: bodyText1),
                    bodyText2: GoogleFonts.notoSansLao(textStyle: bodyText2),
                    headline1: GoogleFonts.notoSansLao(textStyle: header1Text),
                    subtitle1: GoogleFonts.notoSansLao(textStyle: subTitle1)),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    textStyle: loginText,
                    fixedSize: const Size(double.maxFinite, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
      home: const Home(),
    );
  }
}

