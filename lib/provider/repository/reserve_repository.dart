import 'package:regisapp/model/reserve_model.dart';

class ReserveRepository {
  Future<List<ReserveModel>> fetchAllReserve(
      {String? status, String? date}) async {
    return ReserveModel.fetchAllReserve(status: status, date: date);
  }

  Future<List<ReserveModel>> fetchMemberReserve(
      {String? status, String? date}) async {
    return ReserveModel.fetchMemberReserve(
        status: status, date: date);
  }
}
