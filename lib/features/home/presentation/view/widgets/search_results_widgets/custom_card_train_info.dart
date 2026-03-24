
import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/home/presentation/view/pages/stpoes.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/available_tickets_widget.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/ticket_text_button_widget.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/settings_widgets/stations_widget_info.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/train_number_widget.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/seat_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
      child: Card(
        elevation: 7,
        shadowColor: elevationColor,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: elevationColor, width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row
              TrainNumberRow(trainNumber: trainNumber),
              Divider(),
              Gap(6),

              Text(classType, style: Styles.textStyle17), // type tarin
              Divider(),
              const SizedBox(height: 10),

              /// StationsRow
              StationsRow(
                departTime: departTime,
                departDate: departDate,
                fromStation: fromStation,
                arriveTime: arriveTime,
                arriveDate: arriveDate,
                toStation: toStation,
              ),
              Gap(10),
              Divider(),

              /// Duration
              Center(
                child: Text(
                  duration,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Gap(12),

              AvailableTicketsWidget(availableTickets: availableTickets),

              Divider(),

              /// Bottom Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TicketTextButtonWidget(
                    text: "Stops $stops",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              Stpoes(stops: stops, stopStations: stopStations),
                        ),
                      );
                    },
                  ),
                  Container(height: 30, width: 1, color: Colors.grey.shade300),
                  TicketTextButtonWidget(
                    text: "Choosing a seat",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SeatPage()),
                      );
                    },
                  ),
                ],
              ),
              Gap(4),
            ],
          ),
        ),
      ),
    );
  }
}
