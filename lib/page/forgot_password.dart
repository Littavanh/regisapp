import 'package:regisapp/alert/progress.dart';
import 'package:regisapp/controller/customcontainer.dart';
import 'package:regisapp/model/user_model.dart';
import 'package:regisapp/style/color.dart';
import 'package:regisapp/style/size.dart';
import 'package:flutter/material.dart';

class FogotPassworldPage extends StatefulWidget {
  const FogotPassworldPage({Key? key}) : super(key: key);

  @override
  State<FogotPassworldPage> createState() => _FogotPassworldPageState();
}

class _FogotPassworldPageState extends State<FogotPassworldPage> {
  final phone = TextEditingController();
  final password = TextEditingController();
  final rePassword = TextEditingController();
  String emptyPassword = '', emptyUsername = '', warningRePass = '';
  bool _showPassword = true, _showRePassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('ປ່ຽນລະຫັດຜ່ານ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            CustomContainer(
                title: const Text("ເບີໂທລະສັບ"),
                borderRadius: BorderRadius.circular(radius),
                errorMsg: emptyUsername,
                child: TextFormField(
                    controller: phone,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          size: iconSize,
                        )),
                    onChanged: (text) => phone.text.isNotEmpty
                        ? setState(() => emptyUsername = "")
                        : null)),
            CustomContainer(
                title: const Text("ລະຫັດຜ່ານ"),
                borderRadius: BorderRadius.circular(radius),
                errorMsg: emptyPassword,
                child: TextFormField(
                    controller: password,
                    obscureText: _showPassword,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon:
                            const Icon(Icons.security_rounded, size: iconSize),
                        suffixIcon: IconButton(
                            icon: _showPassword
                                ? const Icon(Icons.visibility_rounded,
                                    color: Colors.grey)
                                : const Icon(Icons.visibility_off_rounded,
                                    color: primaryColor),
                            onPressed: () {
                              setState(() => _showPassword = !_showPassword);
                            })),
                    onChanged: (text) =>
                        password.text.isNotEmpty && password.text.length >= 6
                            ? setState(() => emptyPassword = "")
                            : setState(() => emptyPassword =
                                "ລະຫັດຜ່ານຕ້ອງຍາວກວ່າ 5 ຕົວອັກສອນ"))),
            CustomContainer(
                title: const Text("ລະຫັດຜ່ານ"),
                borderRadius: BorderRadius.circular(radius),
                errorMsg: warningRePass,
                child: TextFormField(
                    obscureText: _showRePassword,
                    controller: rePassword,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.security_rounded),
                        suffixIcon: IconButton(
                            icon: _showRePassword
                                ? const Icon(Icons.visibility_rounded,
                                    color: Colors.grey)
                                : const Icon(Icons.visibility_off_rounded,
                                    color: primaryColor),
                            onPressed: () {
                              setState(
                                  () => _showRePassword = !_showRePassword);
                            })),
                    onChanged: (String value) {
                      (value != password.text)
                          ? warningRePass = 'ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ'
                          : warningRePass = '';

                      setState(() {});
                    })),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (phone.text.isNotEmpty && password.text.isNotEmpty) {
                      changePassword(
                          phone: phone.text, password: password.text);
                    } else {
                      emptyUsername = phone.text.isEmpty
                          ? "ກະລຸນາປ້ອນເບີໂທລະສັບ"
                          : emptyUsername = "";
                      emptyPassword =
                          phone.text.isEmpty ? "ກະລຸນາປ້ອນລະຫັດຜ່ານ" : "";
                      setState(() {});
                    }
                  },
                  child: const Text('ບັນທຶກ')),
            ),
          ]),
        ),
      ),
    );
  }

  void changePassword({required String phone, required String password}) async {
    myProgress(context, null);

    await UserModel.changePassword(phone: phone, password: password)
        .then((value) {
      if (value.code == 200) {
        Navigator.pop(context);
        showCompletedDialog(
                context: context,
                title: 'ປ່ຽນລະຫັດຜ່ານ',
                content: 'ປ່ຽນລະຫັດຜ່ານສຳເລັດແລ້ວ')
            .then((value) => Navigator.pop(context));
      } else {
        Navigator.pop(context);
        showFailDialog(
            context: context,
            title: 'ປ່ຽນລະຫັດຜ່ານ',
            content: 'ປ່ຽນລະຫັດຜ່ານບໍ່ສຳເລັດ');
      }
    }).catchError((e) {
      Navigator.pop(context);
      showFailDialog(
          context: context, title: 'ປ່ຽນລະຫັດຜ່ານ', content: e.toString());
    });
  }
}
