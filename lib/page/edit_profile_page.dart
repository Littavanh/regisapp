import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regisapp/alert/progress.dart';
import 'package:regisapp/controller/customcontainer.dart';
import 'package:regisapp/model/user_model.dart';
import 'package:regisapp/page/forgot_password.dart';
import 'package:regisapp/page/login_page.dart';
import 'package:regisapp/page/manegement/form/profile_form.dart';
import 'package:regisapp/source/source.dart';
import 'package:regisapp/storage/storage.dart';
import 'package:regisapp/style/color.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({ Key? key }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: DrawerHeader(
              decoration: const BoxDecoration(color: primaryColor),
              child: Column(
                children: [
                  
                      const Icon(Icons.account_circle_outlined,
                          size: 100, color: iconColor),
                  Text('$userFName $userLName',
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w900)),
                ],
              )),
        ),
        ListTile(
          leading: Icon(Icons.account_circle_rounded,
              color: Theme.of(context).iconTheme.color),
          title: const Text("ແກ້ໄຂໂປຣໄຟຣ"),
          onTap: () async {
            myProgress(context, null);
            await UserModel.fetchUser(userId: userId).then((user) {
              Navigator.pop(context);
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditProfileFrom(user: user)))
                  .then((value) {
                if (value != null && value) {
                  setState(() {});
                }
              }).catchError((e) {
                Navigator.pop(context);
                showFailDialog(
                    context: context,
                    title: 'ແກ້ໄຂໂປຣໄຟຣ',
                    content: e.toString());
              });
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.edit_note_rounded,
              color: Theme.of(context).iconTheme.color),
          title: const Text("ປ່ຽນລະຫັດຜ່ານ"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const FogotPassworldPage()));
          },
        ),
         ListTile(
          leading:  Icon(Icons.info_outline_rounded,
              color: Theme.of(context).iconTheme.color),
          title: const Text("ກ່ຽວກັບ"),
          onTap: () {
           
          },
        ),
         ListTile(
          leading:  Icon(Icons.logout_rounded,
              color: Theme.of(context).iconTheme.color),
          title: const Text("ອອກຈາກລະບົບ"),
          onTap: ()async {
            final remeber = RememberMe(
                                username: '', password: '', remember: false);
                            await remeber.setUser();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginPage()));
                          },
          
        ),
      ]),
    );
  }
  
}