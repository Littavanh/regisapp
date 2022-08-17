import 'package:equatable/equatable.dart';

abstract class VaccineEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchVaccine extends VaccineEvent {
   final int vacsiteId;
  FetchVaccine({
    required this.vacsiteId,
  });
}
class FetchAllVaccine extends VaccineEvent {
  
}

class FetchAllVacsite extends VaccineEvent {}

