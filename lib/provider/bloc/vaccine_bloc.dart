import 'package:regisapp/provider/event/vaccine_event.dart';
import 'package:regisapp/provider/repository/vaccine_repository.dart';
import 'package:regisapp/provider/state/vaccine_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VaccineBloc extends Bloc<VaccineEvent, VaccineState> {
  final VaccineRepository vaccineRepo;
  VaccineBloc({required this.vaccineRepo}) : super(VaccineInitialState()) {
    on<FetchVaccine>((event, emit) async {
      emit(VaccineLoadingState());

      try {
        final vaccines = await vaccineRepo.fetchVaccine(vacsiteId: event.vacsiteId);
        emit(VaccineLoadCompleteState(vaccines: vaccines));
      } on Exception catch (e) {
        emit(VaccineErrorState(error: e.toString()));
      }
    });

    on<FetchAllVaccine>((event, emit) async {
      emit(VaccineLoadingState());

      try {
        final vaccines = await vaccineRepo.fetchAllVaccine();
        emit(VaccineLoadCompleteState(vaccines: vaccines));
      } on Exception catch (e) {
        emit(VaccineErrorState(error: e.toString()));
      }
    });
  }
}
