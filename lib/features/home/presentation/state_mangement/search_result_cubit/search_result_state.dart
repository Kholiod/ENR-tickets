part of 'search_result_cubit.dart';

@immutable
sealed class SearchResultState {}

final class SearchResultInitial extends SearchResultState {}

final class SearchResultLoading extends SearchResultState {}

final class SearchResultSuccess extends SearchResultState {
  final List<TrainInfo> trains; // نموذج بيانات كل رحلة
  SearchResultSuccess({required this.trains});
}

final class SearchResultFailure extends SearchResultState {
  final String errorMessage;
  SearchResultFailure({required this.errorMessage});
}

// نموذج بيانات للرحلة
