// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  void logIn( {required String password, required String email}) async {
    emit(LogInLoding());
    try {
      await Future.delayed(Duration(seconds: 5));
      emit(LogInSuccess());
    } catch (e) {
      emit(LogInFailure(error: e.toString()));
    }
  }
}
