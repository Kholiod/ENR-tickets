import 'package:enr_tickets/features/seat_selection/presentation/state_mangement/cubit/seat_selection_cubit.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/seat_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatGridWidget extends StatelessWidget {
  final int seatCount;
  final String trainType;

  const SeatGridWidget({
    super.key,
    required this.seatCount,
    required this.trainType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
      builder: (context, state) {
        /// ⏳ Loading
        if (state is SeatSelectionLoading) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is SeatSelectionFailure) {
          return Expanded(child: Center(child: Text(state.error)));
        }

        if (state is SeatSelectionLoaded) {
          int rows = (seatCount / 4).ceil();

          return Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: rows,
                itemBuilder: (context, index) {
                  int leftStart = index * 4 + 1;
                  int rightStart = index * 4 + 3;

                  return SeatRowWidget(
                    leftStart: leftStart,
                    rightStart: rightStart,
                    maxSeats: seatCount,
                    isFirstClass: trainType.contains("أولى"),
                  );
                },
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
