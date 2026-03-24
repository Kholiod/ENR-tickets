import 'package:enr_tickets/features/seat_selection/data/model/seatMode.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/seat_widget.dart';

SeatState convert(SeatStatus status) {
  switch (status) {
    case SeatStatus.available:
      return SeatState.available;
    case SeatStatus.selected:
      return SeatState.selected;
    case SeatStatus.booked:
      return SeatState.booked;
  }
}
