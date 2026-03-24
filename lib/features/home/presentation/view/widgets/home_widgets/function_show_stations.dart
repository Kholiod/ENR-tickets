import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/field_select_station.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/stations_list_view.dart';
import 'package:flutter/material.dart';

void showStationsBottomSheet({
  required BuildContext context,
  required List<String> stations,
  required String selectedStation,
  required Function(String) onStationSelected,
}) {
  List<String> filteredStations = List.from(stations);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.75,
            child: Column(
              children: [
                /// search field
                SearchField(
                  onChanged: (value) {
                    setState(() {
                      filteredStations = stations
                          .where(
                            (station) => station.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                          )
                          .toList();
                    });
                  },
                ),

                /// stations list
                Expanded(
                  child: StationsListView(
                    stations: filteredStations,
                    selectedStation: selectedStation,
                    onStationSelected: onStationSelected,
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
