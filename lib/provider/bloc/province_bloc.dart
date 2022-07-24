import 'package:regisapp/provider/event/province_event.dart';
import 'package:regisapp/provider/repository/province_repository.dart';
import 'package:regisapp/provider/state/province_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final ProvinceRepository provinceRepo;
  ProvinceBloc({required this.provinceRepo}) : super(ProvinceInitialState()) {
    on<FetchProvince>((event, emit) async {
      emit(ProvinceLoadingState());

      try {
        final provinces = await provinceRepo.fetchProvince();
        emit(ProvinceLoadCompleteState(provinces: provinces));
      } on Exception catch (e) {
        emit(ProvinceErrorState(error: e.toString()));
      }
    });
  }
}
