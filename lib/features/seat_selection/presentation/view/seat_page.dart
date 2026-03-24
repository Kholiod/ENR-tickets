import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enr_tickets/core/widget/custom_dialog.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/payment_way/presentation/view/payment_way.dart';
import 'package:enr_tickets/features/seat_selection/data/model/seatMode.dart'
    show SeatStatus;
import 'package:enr_tickets/features/seat_selection/presentation/state_mangement/cubit/seat_selection_cubit.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/booking_botton.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/header_widget.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/seat_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SeatPage extends StatelessWidget {
  const SeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SeatSelectionCubit()..loadSeats(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Select Seat",
                style: Styles.textStyle20.copyWith(color: Colors.white),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),

              backgroundColor: Colors.transparent,
              elevation: 0,

              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade800,
                      Colors.red.shade400,
                      Colors.red.shade400,
                      Colors.grey.shade200,
                    ],
                    stops: const [0.0, 0.35, 0.65, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),

              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    const HeaderWidget(),
                    const SizedBox(height: 20),
                    const SeatGridWidget(),
                    const Gap(10),

                    BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
                      builder: (context, state) {
                        // ignore: unused_local_variable
                        bool hasSelection = false;

                        if (state is SeatSelectionLoaded) {
                          hasSelection = state.seats.any(
                            (seat) => seat.status == SeatStatus.selected,
                          );
                        }

                        return BookingBotton(
                          onPressed: () {
                            final cubit = context.read<SeatSelectionCubit>();
                            if (cubit.getSelectedSeats().isEmpty) {
                              CustomDialog.show(
                                context: context,

                                title: "Noticeable",
                                description: "You must choose your seat first.",
                                dialogType: DialogType.noHeader,
                              );
                            } else {
                              CustomDialog.show(
                                context: context,

                                title: "Alert",
                                description: "Are you sure about this booking?",
                                dialogType: DialogType.noHeader,
                                btnOkOnPress: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PaymentWay(),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        );
                      },
                    ),

                    const Gap(12),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
