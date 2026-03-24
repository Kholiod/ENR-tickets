import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/features/seat_selection/presentation/state_mangement/cubit/seat_selection_cubit.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/convert_status.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/seat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SeatRowWidget extends StatelessWidget {
  final int leftStart;
  final int rightStart;

  const SeatRowWidget({
    super.key,
    required this.leftStart,
    required this.rightStart,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
      builder: (context, state) {
        if (state is! SeatSelectionLoaded) {
          return const SizedBox();
        }

        /// get seats from cubit
        final seat1 = state.seats.firstWhere((e) => e.number == leftStart);
        final seat2 = state.seats.firstWhere((e) => e.number == leftStart + 1);
        final seat3 = state.seats.firstWhere((e) => e.number == rightStart);
        final seat4 = state.seats.firstWhere((e) => e.number == rightStart + 1);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Left seats
            Row(
              children: [
                SeatWidget(
                  number: seat1.number,
                  state: convert(seat1.status),
                  onTap: () {
                    context.read<SeatSelectionCubit>().toggleSeat(seat1.number);
                  },
                ),
                const Gap(10),
                SeatWidget(
                  number: seat2.number,
                  state: convert(seat2.status),
                  onTap: () {
                    context.read<SeatSelectionCubit>().toggleSeat(seat2.number);
                  },
                ),
              ],
            ),

            /// this widget special UI
            Seperatedwidget(),

            /// Right seats
            Row(
              children: [
                SeatWidget(
                  number: seat3.number,
                  state: convert(seat3.status),
                  onTap: () {
                    context.read<SeatSelectionCubit>().toggleSeat(seat3.number);
                  },
                ),
                const Gap(10),
                SeatWidget(
                  number: seat4.number,
                  state: convert(seat4.status),
                  onTap: () {
                    context.read<SeatSelectionCubit>().toggleSeat(seat4.number);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class Seperatedwidget extends StatelessWidget {
  const Seperatedwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.1,
      height: MediaQuery.sizeOf(context).height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(color: hintColorForm, width: 0.2),
        color: cardColor,
      ),
    );
  }
}
