import 'package:equatable/equatable.dart';

import 'package:regisapp/model/vacsiteStorage_model.dart';

abstract class VacsiteStorageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VacsiteStorageInitialState extends VacsiteStorageState {}

class VacsiteStorageLoadingState extends VacsiteStorageState {}

class VacsiteStorageLoadCompleteState extends VacsiteStorageState {
  final List<VacsiteStorage> vacsiteStorages;
  VacsiteStorageLoadCompleteState({
    required this.vacsiteStorages,
  });
}

class VacsiteStorageLoadAllCompleteState extends VacsiteStorageState {
  final List<VacsiteStorage> vacsiteStorages;
  VacsiteStorageLoadAllCompleteState({
    required this.vacsiteStorages,
  });
}

class VacsiteStorageErrorState extends VacsiteStorageState {
  final String error;
  VacsiteStorageErrorState({
    required this.error,
  });
}
