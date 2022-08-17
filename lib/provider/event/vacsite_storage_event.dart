import 'package:equatable/equatable.dart';

abstract class VacsiteStorageEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchSearchVaccineWhereVacsite extends VacsiteStorageEvent {
  final int vaccineId;
  FetchSearchVaccineWhereVacsite({
    required this.vaccineId,
  });
}
