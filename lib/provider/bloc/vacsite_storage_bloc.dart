
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regisapp/provider/event/vacsite_storage_event.dart';
import 'package:regisapp/provider/repository/vacsite_storage_repository.dart';
import 'package:regisapp/provider/state/vacsite_storage_state.dart';

class VacsiteStorageBloc extends Bloc<VacsiteStorageEvent, VacsiteStorageState> {
  final VacsiteStorageRepository vacsitestorageRepo;
  VacsiteStorageBloc({required this.vacsitestorageRepo}) : super(VacsiteStorageInitialState()) {
    on<FetchSearchVaccineWhereVacsite>((event, emit) async {
      emit(VacsiteStorageLoadingState());

      try {
        final vacsiteStorage = await vacsitestorageRepo.fetchSearchVaccineWhereVacsite(vaccineId: event.vaccineId);
        emit(VacsiteStorageLoadCompleteState(vacsiteStorages: vacsiteStorage));
      } on Exception catch (e) {
        emit(VacsiteStorageErrorState(error: e.toString()));
      }
    });

   
  }
}
