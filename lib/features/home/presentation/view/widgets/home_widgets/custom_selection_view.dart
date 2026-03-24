import 'dart:developer' show log;

import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/dash_custom.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/selection_station.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/function_show_stations.dart';
import 'package:flutter/material.dart';

class CustomSelectionView extends StatefulWidget {
  final String fromStation;
  final String toStation;

  final Function(String from, String to) onStationsChanged;

  const CustomSelectionView({
    super.key,
    required this.fromStation,
    required this.toStation,
    required this.onStationsChanged,
  });

  @override
  State<CustomSelectionView> createState() => _CustomSelectionViewState();
}

class _CustomSelectionViewState extends State<CustomSelectionView> {
  final List<String> stations = [
    "Cairo",
    "Giza",
    "Alexandria",
    "Tanta",
    "Mansoura",
    "Assiut",
    "Sohag",
    "Qena",
    "Luxor",
    "Aswan",
  ];

  late String fromStation;
  late String toStation;

  @override
  void initState() {
    super.initState();
    fromStation = widget.fromStation;
    toStation = widget.toStation;
  }

  void updateStations() {
    widget.onStationsChanged(fromStation, toStation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// FROM
        GestureDetector(
          onTap: () {
            showStationsBottomSheet(
              selectedStation: fromStation,
              context: context,
              stations: stations,
              onStationSelected: (station) {
                setState(() {
                  fromStation = station;
                });
                updateStations();
              },
            );
          },
          child: SelectionStation(title: fromStation),
        ),

        /// SWAP
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DashesCustom(),
            GestureDetector(
              onTap: () {
                log("Swap Stations");

                setState(() {
                  final temp = fromStation;
                  fromStation = toStation;
                  toStation = temp;
                });

                updateStations();
              },
              child: Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey[200],
                ),
                child: Icon(Icons.swap_vert, color: buttonColor, size: 30),
              ),
            ),
            DashesCustom(),
          ],
        ),

        /// TO
        GestureDetector(
          onTap: () {
            showStationsBottomSheet(
              selectedStation: toStation,
              context: context,
              stations: stations,
              onStationSelected: (station) {
                setState(() {
                  toStation = station;
                });
                updateStations();
              },
            );
          },
          child: SelectionStation(title: toStation),
        ),
      ],
    );
  }
}