import 'dart:ui';

import 'package:regisapp/alert/progress.dart';
import 'package:regisapp/controller/customcontainer.dart';
import 'package:regisapp/model/login_model.dart';
import 'package:regisapp/page/forgot_password.dart';
import 'package:regisapp/page/home_page.dart';
import 'package:regisapp/page/register.dart';

import 'package:regisapp/source/source.dart';

import 'package:regisapp/style/color.dart';
import 'package:regisapp/style/size.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regisapp/storage/storage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  String emptyUsername = "";
  String emptyPassword = "";
  bool _showPassword = true;
  bool isCheck = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
          child: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height,
            //   // child: Image.asset('assets/images/bakg.png'),
            // ),
            Center(
                child: Column(
              children: [
                const SizedBox(height: 40),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    // height: size.height / 3,
                    child: SvgPicture.asset('assets/images/login.svg',color: primaryColor,),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: SizedBox(
                            width: size.width * .9,
                            child: Column(
                              children: [
                                // const Icon(Icons.account_circle, size: 100),
                                Text(
                                  "ລະບົບລົງທະບຽນສັກວັກຊີນ",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                _buildForm()
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      )),
    );
  }

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Form(
        child: Column(children: [
          CustomContainer(
              title: const Text("ເບີໂທລະສັບ"),
              borderRadius: BorderRadius.circular(radius),
              errorMsg: emptyUsername,
              child: TextFormField(
                  controller: _userController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,color: primaryColor,
                        size: iconSize,
                      )),
                  onChanged: (text) => _userController.text.isNotEmpty
                      ? setState(() => emptyUsername = "")
                      : null)),
          CustomContainer(
              title: const Text("ລະຫັດຜ່ານ"),
              borderRadius: BorderRadius.circular(radius),
              errorMsg: emptyPassword,
              child: TextFormField(
                  controller: _passwordController,
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon:
                          const Icon(Icons.security_rounded, size: iconSize,color: primaryColor,),
                      suffixIcon: IconButton(
                          icon: _showPassword
                              ? const Icon(Icons.visibility_rounded,
                                  color: Colors.grey)
                              : const Icon(Icons.visibility_off_rounded,
                                  color: primaryColor),
                          onPressed: () {
                            setState(() => _showPassword = !_showPassword);
                          })),
                  onChanged: (text) => _passwordController.text.isNotEmpty
                      ? setState(() => emptyPassword = "")
                      : null)),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Checkbox(
                activeColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                value: isCheck,
                onChanged: (_isCheck) async {
                  final remeber = RememberMe(
                      username: _userController.text,
                      password: _passwordController.text,
                      remember: false);
                  await remeber.setUser();
                  setState(() {
                    isCheck = _isCheck ?? false;
                  });
                }),
            const Text("ຈື່ຂ້ອຍໄວ້")
          ]),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  if (_userController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    _login();
                  } else {
                    emptyUsername = _userController.text.isEmpty
                        ? "ກະລຸນາປ້ອນເບີໂທລະສັບ"
                        : emptyUsername = "";
                    emptyPassword = _passwordController.text.isEmpty
                        ? "ກະລຸນາປ້ອນລະຫັດຜ່ານ"
                        : "";
                    setState(() {});
                  }
                },
                child: const Text('ເຂົ້າສູ່ລະບົບ')),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Divider(height: 2, color: primaryColor),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Center(
                  child: RichText(
                      text: TextSpan(
                          text: 'ລືມລະຫັດຜ່ານ',
                          style: Theme.of(context).textTheme.bodyText1,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const FogotPassworldPage()));
                            })),
                ),
              ),
              Expanded(
                child: Center(
                  child: RichText(
                      text: TextSpan(
                          text: 'ລົງທະບຽນ',
                          style: Theme.of(context).textTheme.bodyText1,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const RegisterPage()));
                            })),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  void _login() async {
    myProgress(context, Colors.transparent);

    isAdmin = false;
    isEmployee = false;
    isCustomer = false;

    await LoginModel.login(
            data: LoginModel(
                phone: _userController.text,
                password: _passwordController.text))
        .then((login) async {
      if (login.roles != null &&
          login.roles!.isNotEmpty &&
          login.accessToken != null) {
        if (isCheck == true) {
          final remeber = RememberMe(
              username: _userController.text,
              password: _passwordController.text,
              remember: isCheck);
          await remeber.setUser();
        }
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      } else {
        mySnackBar(context, "ບໍ່ສາມາດເຂົ້າສູ່ລະບົບ");
      }
    }).catchError((onError) {
      Navigator.pop(context);
      mySnackBar(context, onError.toString());
    });
  }
}

// class MyScrollBehavior extends ScrollBehavior {
//   @override
//   Widget buildView(
//       BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }
