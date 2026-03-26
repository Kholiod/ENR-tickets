import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:enr_tickets/features/home/presentation/view/pages/stpoes.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/available_tickets_widget.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/ticket_text_button_widget.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/settings_widgets/stations_widget_info.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/train_number_widget.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/seat_page.dart';

class CustomCardTrainInfo extends StatelessWidget {
  final int trainNumber;
  final String classType;
  final String fromStation;
  final String toStation;
  final String departTime;
  final String arriveTime;
  final DateTime departDate;
  final String arriveDate;
  final String duration;
  final int availableTickets;
  final int stops;
  final VoidCallback onBuy;
  final List<String> stopStations;

  const CustomCardTrainInfo({
    super.key,
    required this.trainNumber,
    required this.classType,
    required this.fromStation,
    required this.toStation,
    required this.departTime,
    required this.arriveTime,
    required this.departDate,
    required this.arriveDate,
    required this.duration,
    required this.availableTickets,
    required this.stops,
    required this.onBuy,
    required this.stopStations,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔴 Train Number + Type
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TrainNumberRow(trainNumber: trainNumber),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      classType,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const Gap(12),
              const Divider(thickness: 0.7),

              /// 📍 Stations
              StationsRow(
                departTime: departTime,
                departDate: departDate,
                fromStation: fromStation,
                arriveTime: arriveTime,
                arriveDate: arriveDate,
                toStation: toStation,
              ),

              const Gap(12),
              const Divider(thickness: 0.7),

              /// ⏱ Duration + Available
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 18, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        duration,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  AvailableTicketsWidget(availableTickets: availableTickets),
                ],
              ),

              const Gap(12),
              const Divider(thickness: 0.7),

              /// 🔘 Buttons
              Row(
                children: [
                  Expanded(
                    child: TicketTextButtonWidget(
                      text: "Stops ($stops)",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => Stpoes(
                              stops: stops,
                              stopStations: stopStations,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Container(height: 25, width: 1, color: Colors.grey.shade300),

                  Expanded(
                    child: TicketTextButtonWidget(
                      text: "Choose Seat",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SeatPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const Gap(16),

              /// 🔥 BUY BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: onBuy,
                  child: const Text(
                    "Buy Ticket",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
