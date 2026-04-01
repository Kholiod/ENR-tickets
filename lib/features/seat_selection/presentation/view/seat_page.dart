import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enr_tickets/core/widget/custom_dialog.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/payment_way/presentation/view/payment_way.dart';
import 'package:enr_tickets/features/seat_selection/presentation/state_mangement/cubit/seat_selection_cubit.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/booking_botton.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/header_widget.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/widgets/seat_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SeatPage extends StatelessWidget {
  final int trainNumber;
  final String from;
  final String to;

  const SeatPage({
    super.key,
    required this.trainNumber,
    required this.from,
    required this.to,
  });

  int getSeatPrice() {
    if (trainNumber == 185) return 75;
    if (trainNumber == 2009) return 150;
    if (trainNumber == 2031) return 200;
    return 100;
  }

  @override
  Widget build(BuildContext context) {
    const int seatCount = 60;
    const String trainType = "VIP";
    const int coachNumber = 1;

    return BlocProvider(
      create: (_) => SeatSelectionCubit()..loadSeats(seatCount),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Coach $coachNumber",
            style: Styles.textStyle20.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Text(
                "Train: $trainNumber | $from → $to",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const HeaderWidget(),
              const SizedBox(height: 20),
              SeatGridWidget(seatCount: seatCount, trainType: trainType),
              const Gap(10),
              BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
                builder: (context, state) {
                  final cubit = context.read<SeatSelectionCubit>();
                  final selectedSeats = cubit.getSelectedSeats();
                  final totalPrice = selectedSeats.length * getSeatPrice();

                  return Column(
                    children: [
                      if (selectedSeats.isNotEmpty)
                        Text(
                          "Total: $totalPrice EGP",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      const SizedBox(height: 10),
                      BookingBotton(
                        onPressed: () {
                          if (selectedSeats.isEmpty) {
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PaymentWay(
                                      train: trainNumber.toString(),
                                      trainType: trainType,
                                      coach: coachNumber.toString(),
                                      seats: selectedSeats,
                                      from: from,
                                      to: to,
                                      price: totalPrice.toString(),
                                      name: "Passenger",
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
              const Gap(12),
            ],
          ),
        ),
      ),
    );
  }
}
