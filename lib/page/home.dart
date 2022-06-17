import 'package:flutter/material.dart';
import 'package:regisapp/screen/homeScreen.dart';
import 'package:regisapp/screen/regisScreen.dart';
import 'package:regisapp/style/color.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
 
class _HomeState extends State<Home> {

  int _selectedIndex = 0;

   static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    
      RegisScreen(),
      
    
     Text(
      'ນັດໝາຍ',
      
    ),
   
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  appBar: AppBar(backgroundColor: primaryColor,
                    title: const Text('ແອັບລົງທະບຽນສັກວັກຊີນ'),
                    actions: [
                      IconButton(
                          onPressed: ()  {
                          },
                          tooltip: 'ອອກຈາກລະບົບ',
                          icon: const Icon(Icons.settings_power_outlined,
                              )),
                    ],
                  ),
                 body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
                 bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ໜ້າຫຼັກ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_open_rounded),
            label: 'ລົງທະບຽນ',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.mark_unread_chat_alt),
            label: 'ນັດໝາຍ',
          ),
         
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
                  );
  }
}