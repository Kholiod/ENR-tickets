part of 'creat_user_cubit.dart';

@immutable
sealed class CreatUserState {}

final class CreatUserInitial extends CreatUserState {}

final class CreatUserLoading extends CreatUserState {}

final class CreatUserSuccess extends CreatUserState {}

final class CreatUserFailure extends CreatUserState {
  final String error;

  CreatUserFailure({required this.error});
}
