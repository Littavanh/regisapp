
import 'package:regisapp/provider/event/vacsite_event.dart';
import 'package:regisapp/provider/repository/vacsite_repository.dart';
import 'package:regisapp/provider/state/vacsite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VacsiteBloc extends Bloc<VacsiteEvent, VacsiteState> {
  final VacsiteRepository vacsiteRepo;
  VacsiteBloc({required this.vacsiteRepo}) : super(VacsiteInitialState()) {
    on<FetchVacsite>((event, emit) async {
      emit(VacsiteLoadingState());

      try {
        final vacsites =
            await vacsiteRepo.fetchVacsite(provinceId: event.provinceId);
        emit(VacsiteLoadCompleteState(vacsites: vacsites));
      } on Exception catch (e) {
        emit(VacsiteErrorState(error: e.toString()));
      }
    });


    //  on<FetchSearchVaccineWhereVacsite>((event, emit) async {
    //   emit(VacsiteLoadingState());

    //   try {
    //     final vacsites =
    //         await vacsiteRepo.fetchSearchVaccineWhereVacsite(provinceId: event.provinceId);
    //     emit(VacsiteLoadCompleteState(vacsites: vacsites));
    //   } on Exception catch (e) {
    //     emit(VacsiteErrorState(error: e.toString()));
    //   }
    // });
  }
}
