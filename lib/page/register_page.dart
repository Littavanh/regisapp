import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regisapp/alert/progress.dart';
import 'package:regisapp/controller/customcontainer.dart';
import 'package:regisapp/model/district_model.dart';
import 'package:regisapp/model/province_model.dart';
import 'package:regisapp/model/reserve_model.dart';
import 'package:regisapp/model/vaccine_model.dart';
import 'package:regisapp/model/vacsite_model.dart';
import 'package:regisapp/provider/bloc/district_bloc.dart';
import 'package:regisapp/provider/bloc/province_bloc.dart';
import 'package:regisapp/provider/bloc/vaccine_bloc.dart';
import 'package:regisapp/provider/bloc/vacsite_bloc.dart';
import 'package:regisapp/provider/event/district_event.dart';
import 'package:regisapp/provider/event/province_event.dart';
import 'package:regisapp/provider/event/vacsite_event.dart';
import 'package:regisapp/provider/event/vaccine_event.dart';
import 'package:regisapp/provider/state/district_state.dart';
import 'package:regisapp/provider/state/province_state.dart';
import 'package:regisapp/provider/state/vaccine_state.dart';
import 'package:regisapp/provider/state/vacsite_state.dart';
import 'package:regisapp/source/source.dart';
import 'package:regisapp/style/color.dart';
import 'package:regisapp/style/size.dart';

import '../provider/bloc/reserve_bloc.dart';
import '../provider/event/reserve_event.dart';

class RegisScreen extends StatefulWidget {
  const RegisScreen({Key? key}) : super(key: key);

  @override
  State<RegisScreen> createState() => _RegisScreenState();
}
 final reserveDateController = TextEditingController(text: '');
int provinceId = 0,vaccineId=0,vacsiteId=0;
String date = DateTime.now().toString();
String level="1";

class _RegisScreenState extends State<RegisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                    // height: 10,
                    child: Text(
                        "ການລົງທະບຽນລ່ວງໜ້າສຳລັບກາຮັບວັກຊີນກັນພະຍາດໂຄວິດ-19",
                        style: Theme.of(context).textTheme.headline1)),
              ),
              _buildForm(),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 28),
                  child: ElevatedButton(
                      onPressed: () {
                        final reserve = ReserveModel(
                      
                        vaccineId: vaccineId,
                        vaccinationSiteId: vacsiteId,
                        date: sqldate.format(DateTime.parse(date)),
                        level: int.parse(level),

                          );
                          addReserve(reserve);

                      }, child: const Text("ລົງທະບຽນ")))
            ],
          ),
        ));
  }

  

  Widget _buildForm() {
    return BlocBuilder<ProvinceBloc, ProvinceState>(builder: (_, state) {
      if (state is ProvinceInitialState) {
        context.read<ProvinceBloc>().add(FetchProvince());
      }
      return Form(
        child: CustomContainer(
            padding: const EdgeInsets.only(top: 20),
            borderRadius: BorderRadius.circular(radius),
            child: Column(
              children: [
                // CustomContainer(
                //   title: const Text("ທ່ານຕ້ອງການສັກເຂັມທີ"),
                //   borderRadius: BorderRadius.circular(radius),
                //   padding: const EdgeInsets.only(left: 10),
                //   child: DropdownButton(
                //       value: selectedValue,
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           selectedValue = newValue!;
                //         });
                //       },
                //       items: dropdownItems),
                // ),
                _buildDropdowLevel(),

                Builder(builder: (context) {
                  if (state is ProvinceLoadCompleteState) {
                    return _buildDropdowProvince(state.provinces);
                  } else {
                    return _buildDropdowProvince([]);
                  }
                }),
                // BlocBuilder<DistrictBloc, DistrictState>(
                //     builder: (context, state) {
                //       if (state is DistrictLoadCompleteState) {
                //         return _buildDropdowDistrict(state.districts);
                //       } else {
                //         return _buildDropdowDistrict([]);
                //       }
                //     },
                //   ),
                 BlocBuilder<VacsiteBloc, VacsiteState>(
                  
                    builder: (context, state) {
                      if (state is VacsiteLoadCompleteState) {
                        return _buildDropdowVacsite(state.vacsites);
                      } else {
                        return _buildDropdowVacsite([]);
                      }
                    },
                  ),

                  BlocBuilder<VaccineBloc, VaccineState>(
                  
                    builder: (context, state) {
                      if (state is VaccineLoadCompleteState) {
                        return _buildDropdowVaccine(state.vaccines);
                      } else {
                        return _buildDropdowVaccine([]);
                      }
                    },
                  ),
             
                CustomContainer(
                    title: const Text("ເລືອກວັນສັກ"),
                    borderRadius: BorderRadius.circular(radius),
                    child: TextFormField(
                        controller: reserveDateController,
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 10),
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate:DateTime.now(),
                                          lastDate:  DateTime(
                                              DateTime.now().year +1),
                                          helpText: 'ເລືອກວັນສັກ',
                                          cancelText: 'ຍົກເລີກ',
                                          confirmText: 'ຕົກລົງ')
                                      .then((value) {
                                    setState(() {
                                      date = value != null
                                                  ? value.toString()
                                                  : DateTime.now().toString();
                                              reserveDateController.text =
                                                  fmdate.format(
                                                      value ?? DateTime.now());
                                    });
                                  });
                                },
                                icon: const Icon(Icons.date_range))))),
              ],
            )),
      );
    });
  }

  Widget _buildDropdowProvince(List<ProvinceModel> provinces) {
    return CustomContainer(
        title: const Text("ເລືອກແຂວງ"),
        borderRadius: BorderRadius.circular(radius),
        padding: const EdgeInsets.only(left: 10),
        child: DropdownSearch<String>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            maxHeight: MediaQuery.of(context).size.height / 1.4,
            searchFieldProps: const TextFieldProps(
                decoration: InputDecoration(
                    helperText: 'ເລືອກແຂວງ',
                    hintText: 'ຄົ້ນຫາ',
                    suffixIcon: Icon(Icons.search_rounded))),
            dropdownSearchDecoration:
                const InputDecoration(border: InputBorder.none),
            items: provinces.map((e) => e.name).toList(),
            compareFn: (String? i, String? s) => (i == s) ? true : false,
            onChanged: (value) {
              for (var element in provinces) {
                if (element.name == value) {
                  provinceId = element.id ?? 0;
                  context
                      .read<VacsiteBloc>()
                      .add(FetchVacsite(provinceId: provinceId));
                  return;
                }
              }
            }));
  }

  Widget _buildDropdowLevel() {
    return CustomContainer(
        title: const Text("ທ່ານຕ້ອງການສັກເຂັມທີ"),
        borderRadius: BorderRadius.circular(radius),
        padding: const EdgeInsets.only(left: 10),
        child: DropdownSearch<String>(
          mode: Mode.DIALOG,
          showSearchBox: false,
          maxHeight: MediaQuery.of(context).size.height / 1.4,
          searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                  helperText: 'ເລືອກເຂັມ',
                  hintText: 'ຄົ້ນຫາ',
                  suffixIcon: Icon(Icons.search_rounded))),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none),
          items: const["1","2","3","4"],
           compareFn: (String? i, String? s) => (i == s) ? true : false,
          onChanged: (String? newValue) {
            setState(() {
              level = newValue!;
            });
          },
        ));
  }
// Widget _buildDropdowDistrict(List<DistrictModel> districts) {
//     return CustomContainer(
//         title: const Text("ເມືອງ"),
//         borderRadius: BorderRadius.circular(radius),
//         padding: const EdgeInsets.only(left: 10),
//         child: DropdownSearch<String>(
//             mode: Mode.DIALOG,
//             showSearchBox: true,
//             maxHeight: MediaQuery.of(context).size.height / 1.4,
//             searchFieldProps: const TextFieldProps(
//                 decoration: InputDecoration(
//                     helperText: 'ເລືອກເມືອງ',
//                     hintText: 'ຄົ້ນຫາ',
//                     suffixIcon: Icon(Icons.search_rounded))),
//             dropdownSearchDecoration:
//                 const InputDecoration(border: InputBorder.none),
//             items: districts.map((e) => e.name).toList(),
//             compareFn: (String? i, String? s) => (i == s) ? true : false,
//             onChanged: (value) {
//               for (var element in districts) {
//                 if (element.name == value) {
//                   districtId = element.id ?? 0;
//                   return;
//                 }
//               }
//             }));
//   }

  Widget _buildDropdowVacsite(List<VacsiteModel> vacsite) {
    return CustomContainer(
        title: const Text("ເລືອກສະຖານທີ່"),
        borderRadius: BorderRadius.circular(radius),
        padding: const EdgeInsets.only(left: 10),
        child: DropdownSearch<String>(
          mode: Mode.DIALOG,
          showSearchBox: true,
          maxHeight: MediaQuery.of(context).size.height / 1.4,
          searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                  helperText: 'ເລືອກສະຖານທີ່',
                  hintText: 'ຄົ້ນຫາ',
                  suffixIcon: Icon(Icons.search_rounded))),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none),
           items: vacsite.map((e) => e.name).toList(),
            compareFn: (String? i, String? s) => (i == s) ? true : false,
            onChanged: (value) {
              for (var element in vacsite) {
                if (element.name == value) {
                  vacsiteId = element.id ?? 0;
                  context
                      .read<VaccineBloc>()
                      .add(FetchVaccine(vacsiteId: vacsiteId));
                  return;
                }
              }
            },
        ));
  }

  Widget _buildDropdowVaccine(List<VaccineModel> vaccines) {
    return CustomContainer(
        title: const Text("ເລືອກວັກຊີນ"),
        borderRadius: BorderRadius.circular(radius),
        padding: const EdgeInsets.only(left: 10),
        child: DropdownSearch<String>(
          mode: Mode.DIALOG,
          showSearchBox: true,
          maxHeight: MediaQuery.of(context).size.height / 1.4,
          searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                  helperText: 'ເລືອກວັກຊີນ',
                  hintText: 'ຄົ້ນຫາ',
                  suffixIcon: Icon(Icons.search_rounded))),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none),
            items: vaccines.map((e) => e.name).toList(),
            compareFn: (String? i, String? s) => (i == s) ? true : false,
            onChanged: (value) {
              for (var element in vaccines) {
                if (element.name == value) {
              vaccineId = element.id ?? 0;
                  return;
                }
              }}
        ));
  }

  void addReserve(ReserveModel data) async {
    myProgress(context, null);
    

     await ReserveModel.postReserve(data: data).then((value) async {
      Navigator.pop(context);
      showCompletedDialog(
              context: context,
              title: 'ບັນທືກ',
              content: 'ບັນທືກການລົງທະບຽນສຳເລັດແລ້ວ')
          .then((value) {
        context.read<ReserveBloc>().add(FetchMemberReserve(status: 'Pending',date: sqldate.format(DateTime.parse(date))));
        
      });
    }).catchError((e) {
      Navigator.pop(context);
      showFailDialog(context: context, title: 'ເຕືອນ', content: e.toString());
    });
  
   
  }
}
