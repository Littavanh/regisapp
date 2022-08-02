import 'package:regisapp/model/reserve_model.dart';
import 'package:regisapp/provider/event/reserve_event.dart';

class ReserveRepository {
  Future<List<ReserveModel>> fetchAllReserve(
      {String? status, String? date}) async {
    return ReserveModel.fetchAllReserve(status: status, date: date);
  }

   Future<List<ReserveModel>> fetchUserComplete()
     async {
    return ReserveModel.fetchUserComplete();
  }
     Future<List<ReserveModel>> fetchUserPending()
     async {
    return ReserveModel.fetchUserPending();
  }

  Future<List<ReserveModel>> fetchMemberReserve(
      {String? status, String? date}) async {
    return ReserveModel.fetchMemberReserve(
        status: status, date: date);
  }
}
