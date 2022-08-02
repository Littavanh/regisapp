import 'package:equatable/equatable.dart';

abstract class ReserveEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchAllReserve extends ReserveEvent {
  final String? status;
  final String? date;
  FetchAllReserve({
    this.status,
    this.date,
    
  });
}

class FetchMemberReserve extends ReserveEvent {
  final String? status;
  final String? date;
  FetchMemberReserve({
    this.status,
    this.date
  });
}

class FetchUserComplete extends ReserveEvent{

}
class FetchUserPending extends ReserveEvent{}
