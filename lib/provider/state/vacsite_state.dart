import 'package:equatable/equatable.dart';

import 'package:regisapp/model/vacsite_model.dart';

abstract class VacsiteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VacsiteInitialState extends VacsiteState {}

class VacsiteLoadingState extends VacsiteState {}

class VacsiteLoadCompleteState extends VacsiteState {
  final List<VacsiteModel> vacsites;
  VacsiteLoadCompleteState({
    required this.vacsites,
  });
}

class VacsiteLoadAllCompleteState extends VacsiteState {
  final List<VacsiteModel> vacsites;
  VacsiteLoadAllCompleteState({
    required this.vacsites,
  });
}

class VacsiteErrorState extends VacsiteState {
  final String error;
  VacsiteErrorState({
    required this.error,
  });
}
