import 'package:flutter/material.dart';

class ReserveDetails extends StatefulWidget {
  const ReserveDetails({Key? key}) : super(key: key);

  @override
  State<ReserveDetails> createState() => _ReserveDetailsState();
}

class _ReserveDetailsState extends State<ReserveDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text("ນັດໝາຍການສັກວັກຊີນ"),
        ));
  }
}
