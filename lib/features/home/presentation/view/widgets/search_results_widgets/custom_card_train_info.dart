import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/stops_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:enr_tickets/features/home/presentation/view/pages/stpoes.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/available_tickets_widget.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/ticket_text_button_widget.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/settings_widgets/stations_widget_info.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/train_number_widget.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/seat_page.dart';

class CustomCardTrainInfo extends StatelessWidget {
  final int trainNumber, availableTickets, stops;
  final String classType,
      fromStation,
      toStation,
      departTime,
      arriveTime,
      arriveDate,
      duration;
  final DateTime departDate;
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

  Widget get _divider =>
      Divider(height: 18, thickness: .5, color: Colors.grey.shade300);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 4),
              color: Colors.black12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _divider,
            _stations(),
            _divider,
            _info(),
            _divider,
            _actions(context),

            if (stopStations.isNotEmpty) ...[
              const Gap(10),
              StopsWidget(stops: stopStations),
            ],

            const Gap(12),
            _buyButton(),
          ],
        ),
      ),
    );
  }

  Widget _header() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TrainNumberRow(trainNumber: trainNumber),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          classType,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );

  Widget _stations() => StationsRow(
    departTime: departTime,
    departDate: departDate,
    fromStation: fromStation,
    arriveTime: arriveTime,
    arriveDate: arriveDate,
    toStation: toStation,
  );

  Widget _info() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          const Icon(Icons.timer, size: 16, color: Colors.grey),
          const SizedBox(width: 5),
          Text(
            duration,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      AvailableTicketsWidget(availableTickets: availableTickets),
    ],
  );

  Widget _actions(BuildContext context) => Row(
    children: [
      Expanded(
        child: TicketTextButtonWidget(
          text: "Stops ($stops)",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Stpoes(stops: stops, stopStations: stopStations),
            ),
          ),
        ),
      ),
      Container(height: 20, width: 1, color: Colors.grey.shade300),
      Expanded(
        child: TicketTextButtonWidget(
          text: "Choose Seat",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SeatPage(
                trainNumber: trainNumber,
                from: fromStation,
                to: toStation,
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buyButton() => SizedBox(
    width: double.infinity,
    height: 45,
    child: ElevatedButton(
      onPressed: onBuy,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        "Buy Ticket",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
