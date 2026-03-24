// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'creat_user_state.dart';

class CreatUserCubit extends Cubit<CreatUserState> {
  CreatUserCubit() : super(CreatUserInitial());
  void createUser() async{
    emit(CreatUserLoading());
    try {
     await Future.delayed(Duration(seconds: 5));
      emit(CreatUserSuccess());
    } catch (e) {
      emit(CreatUserFailure(error: e.toString()));
    }
  }
}
