// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:enr_tickets/features/seat_selection/data/model/seatMode.dart';
import 'package:meta/meta.dart';

part 'seat_selection_state.dart';

class SeatSelectionCubit extends Cubit<SeatSelectionState> {
  SeatSelectionCubit() : super(SeatSelectionLoading());

  /// simulate API
  void loadSeats() async {
    emit(SeatSelectionLoading());

    try {
      await Future.delayed(const Duration(seconds: 5));

      /// dummy data (كأنها جاية من API)
      final seats = List.generate(28, (index) {
        if (index % 5 == 0) {
          return SeatModel(
            number: index + 1,
            status: SeatStatus.booked,
          ); //semilation for booked status
        }
        return SeatModel(
          number: index + 1,
          status: SeatStatus.available,
        ); //Semilation for availabel status
      });

      emit(SeatSelectionLoaded(seats: seats));
    } catch (e) {
      emit(SeatSelectionFailure(e.toString()));
    }
  }

  /// chose set
  void toggleSeat(int seatNumber) {
    if (state is! SeatSelectionLoaded) return;

    final current = state as SeatSelectionLoaded;

    final updated = current.seats.map((seat) {
      if (seat.number == seatNumber) {
        if (seat.status == SeatStatus.booked) return seat;

        return seat.copyWith(
          status: seat.status == SeatStatus.selected
              ? SeatStatus.available
              : SeatStatus.selected,
        );
      }
      return seat;
    }).toList();

    emit(SeatSelectionLoaded(seats: updated));
  }
  List<SeatModel> getSelectedSeats() {
  if (state is! SeatSelectionLoaded) return [];

  final current = state as SeatSelectionLoaded;

  return current.seats
      .where((seat) => seat.status == SeatStatus.selected)
      .toList();
}
}
