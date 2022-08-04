import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regisapp/component/component.dart';
import 'package:regisapp/model/reserve_model.dart';
import 'package:regisapp/provider/bloc/reserve_bloc.dart';
import 'package:regisapp/provider/event/reserve_event.dart';

import 'package:regisapp/provider/state/reserve_state.dart';
import 'package:regisapp/style/color.dart';
import 'package:regisapp/style/textstyle.dart';

class Reserve_History extends StatefulWidget {
  const Reserve_History({ Key? key }) : super(key: key);

  @override
  State<Reserve_History> createState() => _Reserve_HistoryState();
}

class _Reserve_HistoryState extends State<Reserve_History> {

   Future<void> _onRefresh() async {
    Future.delayed(const Duration(seconds: 0));
    context.read<ReserveBloc>().add(FetchUserComplete());
  }
  @override
 Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("ປະຫວັດການສັກວັກຊີນ"),
        // actions: [
        //   IconButton(
        //       onPressed: () => Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (_) =>
        //                 const PostFormEditor(title: 'ເພີ່ມ', edit: false),
        //           )),
        //       icon: const Icon(Icons.add_circle_outline))
        // ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<ReserveBloc, ReserveState>(
            builder: (context, state) {
              if (state is ReserveInitialState) {
                _onRefresh();
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ReserveLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ReserveLoadCompleteState) {
                if (state.reserves.isEmpty) return _isStateEmty();
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                      itemCount: state.reserves.length,
                      itemBuilder: (_, index) {
                        return buildCard(state.reserves[index]);
                      }
                      
                      ),
                );
              }

              if (state is ReserveErrorState) {
                return _isStateEmty(message: state.error);
              } else {
                return _isStateEmty();
              }
            },
          )),
    );
  }

 Widget buildCard(ReserveModel reserve) {
    return InkWell( 
      child: Component(
        
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(top: 12),
        child: Container(
          
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ວັນທີສັກ: ${reserve.date}", style: bodyText2Bold),
                    const Divider(color: primaryColor,),
                    const Text("ລາຍລະອຽດ: ", style: bodyText2Bold),
                    Text('*ເຂັມທີ ${reserve.level}',
                    
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                        Text('*ຊະນິດວັກຊີນ ${reserve.vaccine!.name}',
                    
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                         Text('*ສະຖານທີ່ສັກ ${reserve.vacsite!.name}',
                    
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
    
              // const Spacer(),
              // Column(
              //   children: [
              //     // EditButton(onPressed: () {
              //     //   Navigator.push(
              //     //       context,
              //     //       MaterialPageRoute(
              //     //         builder: (_) => PostFormEditor(
              //     //             title: 'ເບິ່ງລາຍລະອຽດ', edit: true, post: post),
              //     //       ));
              //     // }),
              //     // const SizedBox(height: 15),
              //     // DeleteButton(onPressed: () {
              //     //   showQuestionDialog(
              //     //           context: context,
              //     //           title: 'ລຶບ',
              //     //           content: "ຕ້ອງການລຶບຂໍ້ມູນແມ່ນບໍ?")
              //     //       .then((value) {
              //     //     if (value != null && value) {
              //     //       onDelete(post.id ?? 0);
              //     //     }
              //     //   });
              //     // })
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }


 Widget _isStateEmty({String? message}) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () => _onRefresh(),
            icon:
                const Icon(Icons.sync_rounded, size: 30, color: primaryColor)),
        const SizedBox(
          width: 10,
        ),
        Text(message ?? 'ບໍ່ມີຂໍ້ມູນ'),
      ],
    ));
  }
  }
