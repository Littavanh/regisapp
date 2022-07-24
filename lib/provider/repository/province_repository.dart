import 'package:regisapp/model/province_model.dart';

class ProvinceRepository {
  Future<List<ProvinceModel>> fetchProvince() async {
    return await ProvinceModel.fetchProvince();
  }
}
