import 'package:equatable/equatable.dart';

abstract class VacsiteEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchVacsite extends VacsiteEvent {
  final int provinceId;
  FetchVacsite({
    required this.provinceId,
  });
}

class FetchAllVacsite extends VacsiteEvent {}
