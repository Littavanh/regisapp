import 'package:regisapp/provider/event/user_event.dart';
import 'package:regisapp/provider/repository/user_repository.dart';
import 'package:regisapp/provider/state/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepo;
  UserBloc({required this.userRepo}) : super(UserInitialState()) {
    on<FetchUser>((event, emit) async {
      emit(UserLoadingState());

      try {
        final users = await userRepo.fetchAllUser();
        emit(UserLoadCompleteState(users: users));
      } on Exception catch (e) {
        emit(UserErrorState(error: e.toString()));
      }
    });

    on<FetchEmployee>((event, emit) async {
      emit(EmployeeLoadingState());

      try {
        final employees = await userRepo.fetchEmployee();
        emit(EmployeeLoadCompleteState(employees: employees));
      } on Exception catch (e) {
        emit(EmployeeErrorState(error: e.toString()));
      }
    });

    on<FetchCustomer>((event, emit) async {
      emit(CustomerLoadingState());

      try {
        final customers = await userRepo.fetchCustomer();
        emit(CustomerLoadCompleteState(customers: customers));
      } on Exception catch (e) {
        emit(CustomerErrorState(error: e.toString()));
      }
    });
  }
}
