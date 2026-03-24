import 'package:enr_tickets/features/home/presentation/view/widgets/stops_widsgets/station_time_line.dart';
import 'package:flutter/material.dart';

class Stpoes extends StatelessWidget {
  final int stops;
  final List<String> stopStations;
  const Stpoes({super.key, required this.stops, required this.stopStations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              "$stops Stops",
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),

            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: StationTimeline(stations: stopStations),
              ),
            ],
          );
        },
      ),
    );
  }
}
