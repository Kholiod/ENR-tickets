// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:enr_tickets/features/seat_selection/data/model/seatMode.dart';
import 'package:meta/meta.dart';

part 'seat_selection_state.dart';

class SeatSelectionCubit extends Cubit<SeatSelectionState> {
  SeatSelectionCubit() : super(SeatSelectionLoading());

  /// ✅ خد seatCount من بره
  void loadSeats(int seatCount) async {
    emit(SeatSelectionLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      /// 🔥 generate حسب العدد الحقيقي
      final seats = List.generate(seatCount, (index) {
        if (index % 5 == 0) {
          return SeatModel(number: index + 1, status: SeatStatus.booked);
        }

        return SeatModel(number: index + 1, status: SeatStatus.available);
      });

      emit(SeatSelectionLoaded(seats: seats));
    } catch (e) {
      emit(SeatSelectionFailure(e.toString()));
    }
  }

  /// اختيار كرسي
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

  /// الكراسي المختارة
  List<SeatModel> getSelectedSeats() {
    if (state is! SeatSelectionLoaded) return [];

    final current = state as SeatSelectionLoaded;

    return current.seats
        .where((seat) => seat.status == SeatStatus.selected)
        .toList();
  }
}
