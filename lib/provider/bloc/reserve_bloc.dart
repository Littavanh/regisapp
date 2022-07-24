import 'package:regisapp/provider/event/reserve_event.dart';
import 'package:regisapp/provider/repository/reserve_repository.dart';
import 'package:regisapp/provider/state/reserve_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReserveBloc<ReserveModel> extends Bloc<ReserveEvent, ReserveState> {
  final ReserveRepository reserveRepo;

  ReserveBloc({required this.reserveRepo}) : super(ReserveInitialState()) {
    on<FetchAllReserve>((event, emit) async {
      emit(ReserveLoadingState());

      try {
        final reserves = await reserveRepo.fetchAllReserve(
            status: event.status, date: event.date);
      
        emit(ReserveLoadCompleteState(reserves: reserves,));
      } on Exception catch (e) {
        emit(ReserveErrorState(error: e.toString()));
      }
    });

    on<FetchMemberReserve>((event, emit) async {
      emit(ReserveLoadingState());

      try {
        final reserves = await reserveRepo.fetchMemberReserve(
            status: event.status, date: event.date);
        emit(ReserveLoadCompleteState(reserves: reserves));
      } on Exception catch (e) {
        emit(ReserveErrorState(error: e.toString()));
      }
    });
  }
}
