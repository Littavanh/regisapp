import 'package:regisapp/model/vaccine_model.dart';

class VaccineRepository {
  Future<List<VaccineModel>> fetchVaccine({required int vacsiteId})  async {
    return await VaccineModel.fetchVaccine(vacsiteId: vacsiteId);
  }
  Future<List<VaccineModel>> fetchAllVaccine()  async {
    return await VaccineModel.fetchAllVaccine();
  }
}
