import 'package:regisapp/model/vacsite_model.dart';

class VacsiteRepository {
  Future<List<VacsiteModel>> fetchVacsite({required int provinceId}) async {
    return await VacsiteModel.fetchVacsiteById(provinceId: provinceId);
  }
}
