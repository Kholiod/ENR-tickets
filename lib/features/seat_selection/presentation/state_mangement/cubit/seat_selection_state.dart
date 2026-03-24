part of 'seat_selection_cubit.dart';

@immutable
sealed class SeatSelectionState {}

final class SeatSelectionInitial extends SeatSelectionState {}

// status spechial for Api
class SeatSelectionLoading extends SeatSelectionState {}

class SeatSelectionFailure extends SeatSelectionState {       
  final String error;
  SeatSelectionFailure(this.error);
}

// Status Spechial seats
final class SeatSelectionLoaded extends SeatSelectionState {
  final List<SeatModel> seats;

  SeatSelectionLoaded({required this.seats});
}





