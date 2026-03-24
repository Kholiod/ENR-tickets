import 'package:enr_tickets/features/seat_selection/presentation/state_mangement/cubit/seat_selection_cubit.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/seat_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatGridWidget extends StatelessWidget {
  const SeatGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
      builder: (context, state) {
        ///  Loading
        if (state is SeatSelectionLoading) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        /// ❌ Error
        if (state is SeatSelectionFailure) {
          return Expanded(child: Center(child: Text(state.error)));
        }

        /// ✅ Success
        if (state is SeatSelectionLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                int left = index * 4 + 1;
                int right = index * 4 + 3;

                return SeatRowWidget(leftStart: left, rightStart: right);
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
