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
  final String trainNumber;
  final String trainType;
  final int coachNumber;
  final int seatCount;

  const SeatPage({
    super.key,
    required this.trainNumber,
    required this.trainType,
    required this.coachNumber,
    required this.seatCount,
  });

  /// 💰 سعر الكرسي
  int getSeatPrice() {
    if (trainNumber == "185") return 75;
    if (trainNumber == "2009") return 150;
    if (trainNumber == "2031") return 200;
    return 100;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SeatSelectionCubit()..loadSeats(seatCount),
      child: Builder(
        builder: (context) {
          return Scaffold(
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
              centerTitle: true,
            ),

            body: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    /// 🚆 بيانات القطر
                    Text(
                      "Train: $trainNumber | Type: $trainType",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const HeaderWidget(),
                    const SizedBox(height: 20),

                    /// 🔥 التعديل هنا
                    SeatGridWidget(
                      seatCount: seatCount,
                      trainType: trainType, // ✅ الصح
                    ),

                    const Gap(10),

                    /// 💰 السعر + الزرار
                    BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
                      builder: (context, state) {
                        final cubit = context.read<SeatSelectionCubit>();
                        final selectedSeats = cubit.getSelectedSeats();

                        final totalPrice =
                            selectedSeats.length * getSeatPrice();

                        return Column(
                          children: [
                            /// 💰 السعر
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

                            /// 🔘 زرار الحجز
                            BookingBotton(
                              onPressed: () {
                                if (selectedSeats.isEmpty) {
                                  CustomDialog.show(
                                    context: context,
                                    title: "Noticeable",
                                    description:
                                        "You must choose your seat first.",
                                    dialogType: DialogType.noHeader,
                                  );
                                } else {
                                  CustomDialog.show(
                                    context: context,
                                    title: "Alert",
                                    description:
                                        "Are you sure about this booking?",
                                    dialogType: DialogType.noHeader,
                                    btnOkOnPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PaymentWay(
                                            train: trainNumber,
                                            trainType: trainType,
                                            coach: coachNumber.toString(),
                                            seats: selectedSeats,
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
        },
      ),
    );
  }
}
