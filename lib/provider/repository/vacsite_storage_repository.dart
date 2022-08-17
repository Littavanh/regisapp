import 'package:regisapp/model/vacsiteStorage_model.dart';

class VacsiteStorageRepository {
  Future<List<VacsiteStorage>> fetchSearchVaccineWhereVacsite({required int vaccineId}) async {
    return await VacsiteStorage.fetchSearchVaccineWhereVacsite(vaccineId: vaccineId);
  }
}
