import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:regisapp/page/home_page.dart';
import 'package:regisapp/page/slapscreen.dart';
import 'package:regisapp/provider/bloc/district_bloc.dart';
import 'package:regisapp/provider/bloc/notification_bloc.dart';
import 'package:regisapp/provider/bloc/post_bloc.dart';
import 'package:regisapp/provider/bloc/province_bloc.dart';
import 'package:regisapp/provider/bloc/reserve_bloc.dart';
import 'package:regisapp/provider/bloc/user_bloc.dart';
import 'package:regisapp/provider/bloc/vaccine_bloc.dart';
import 'package:regisapp/provider/bloc/vacsite_bloc.dart';
import 'package:regisapp/provider/bloc/vacsite_storage_bloc.dart';
import 'package:regisapp/provider/notification_provider.dart';
import 'package:regisapp/provider/repository/district_repository.dart';
import 'package:regisapp/provider/repository/notification_repository.dart';
import 'package:regisapp/provider/repository/post_repository.dart';
import 'package:regisapp/provider/repository/province_repository.dart';
import 'package:regisapp/provider/repository/reserve_repository.dart';
import 'package:regisapp/provider/repository/user_repository.dart';
import 'package:regisapp/provider/repository/vaccine_repository.dart';
import 'package:regisapp/provider/repository/vacsite_repository.dart';
import 'package:regisapp/provider/repository/vacsite_storage_repository.dart';
import 'package:regisapp/setting/sharesetting.dart';

import 'package:regisapp/style/color.dart';
import 'package:regisapp/style/size.dart';
import 'package:regisapp/style/textstyle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SettingShareService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProvinceBloc>(
            create: (_context) =>
                ProvinceBloc(provinceRepo: ProvinceRepository())),
        BlocProvider<DistrictBloc>(
            create: (_context) =>
                DistrictBloc(districtRepo: DistrictRepository())),
        BlocProvider<PostBloc>(
            create: (_context) => PostBloc(postRepo: PostRepository())),
        
        BlocProvider<UserBloc>(
            create: (_context) => UserBloc(userRepo: UserRepository())),
        BlocProvider<VacsiteBloc>(
            create: (_context) =>
                VacsiteBloc(vacsiteRepo: VacsiteRepository())),
        BlocProvider<VaccineBloc>(
            create: (_context) =>
                VaccineBloc(vaccineRepo: VaccineRepository())),
                BlocProvider<VacsiteStorageBloc>(
            create: (_context) =>
                VacsiteStorageBloc(vacsitestorageRepo:VacsiteStorageRepository())),
        BlocProvider<ReserveBloc>(
            create: (_context) =>
                ReserveBloc(reserveRepo: ReserveRepository())),
        BlocProvider<NotificationBloc>(
            create: (_context) =>
                NotificationBloc(notificationRepo: NotificationRepository())),
      ],
      child: ChangeNotifierProvider<NotificationManager>(
          create: (_) => NotificationManager(),
          builder: (context, child) {
            return MaterialApp(
              title: 'Register Covid App',
              debugShowCheckedModeBanner: false,
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
              home: const SlapScreen(),
            );
          }),
    );
  }
}
