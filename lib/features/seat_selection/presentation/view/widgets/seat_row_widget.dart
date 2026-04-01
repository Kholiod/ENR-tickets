import 'package:enr_tickets/features/seat_selection/data/model/seatMode.dart';
import 'package:enr_tickets/features/seat_selection/presentation/state_mangement/cubit/seat_selection_cubit.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/convert_status.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/seat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatRowWidget extends StatelessWidget {
  final int leftStart;
  final int rightStart;
  final int maxSeats;
  final bool isFirstClass;

  const SeatRowWidget({
    super.key,
    required this.leftStart,
    required this.rightStart,
    required this.maxSeats,
    required this.isFirstClass,
  });

  SeatModel? getSeat(List<SeatModel> seats, int number) {
    try {
      return seats.firstWhere((e) => e.number == number);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
      builder: (context, state) {
        if (state is! SeatSelectionLoaded) {
          return const SizedBox();
        }

        final List<SeatModel> seats = state.seats;

        final seat1 = getSeat(seats, leftStart);
        final seat2 = getSeat(seats, leftStart + 1);
        final seat3 = getSeat(seats, rightStart);
        final seat4 = getSeat(seats, rightStart + 1);

        Widget buildSeat(SeatModel? seat) {
          if (seat == null || seat.number > maxSeats) {
            return const SizedBox(width: 45);
          }

          return SeatWidget(
            number: seat.number,
            state: convert(seat.status),
            onTap: () {
              context.read<SeatSelectionCubit>().toggleSeat(seat.number);
            },
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  buildSeat(seat1),
                  const SizedBox(width: 6),
                  buildSeat(seat2),
                ],
              ),

              const SizedBox(width: 15),

              Container(
                width: 25,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (index) =>
                        Container(width: 12, height: 2, color: Colors.grey),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              isFirstClass
                  ? buildSeat(seat3)
                  : Row(
                      children: [
                        buildSeat(seat3),
                        const SizedBox(width: 6),
                        buildSeat(seat4),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
