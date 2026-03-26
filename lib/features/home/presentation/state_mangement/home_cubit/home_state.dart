part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSearchSuccess extends HomeState {
  final String from;
  final String to;
  final DateTime date;
  final List<String> stopStation;

  HomeSearchSuccess({
    required this.from,
    required this.to,
    required this.date,
    required this.stopStation,
  });
}

class HomeFailure extends HomeState {
  final String errorMessage;

  HomeFailure({required this.errorMessage});
}
