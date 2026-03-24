part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoding extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<String> stations;

  HomeSuccess({required this.stations});
}

final class HomeFailure extends HomeState {
  final String errorMessage;

  HomeFailure({required this.errorMessage});
}


final class HomeSearchSuccess extends HomeState {
  final String from;
  final String to;
  final DateTime date;
  final String tripType;
  final List<String> stopStation;

  HomeSearchSuccess({
    required this.from,
    required this.to,
    required this.date,
    required this.tripType, required this.stopStation,
  });
}