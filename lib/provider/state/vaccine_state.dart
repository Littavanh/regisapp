import 'package:equatable/equatable.dart';

import 'package:regisapp/model/vaccine_model.dart';

abstract class VaccineState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VaccineInitialState extends VaccineState {}

class VaccineLoadingState extends VaccineState {}

class VaccineLoadCompleteState extends VaccineState {
  final List<VaccineModel> vaccines;
  VaccineLoadCompleteState({
    required this.vaccines,
  });
}

class VaccineErrorState extends VaccineState {
  final String error;
  VaccineErrorState({
    required this.error,
  });
}
