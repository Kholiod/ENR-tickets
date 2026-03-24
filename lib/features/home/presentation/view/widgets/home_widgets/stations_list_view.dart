import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class StationsListView extends StatelessWidget {
  final List<String> stations;
  final String selectedStation;
  final Function(String) onStationSelected;

  const StationsListView({
    super.key,
    required this.stations,
    required this.selectedStation,
    required this.onStationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];

        return Card(
          color: Colors.white,
          child: ListTile(
            title: Text(
              station,
              style: Styles.textStyle20,
            ),

            leading: Image.asset(
              AssetsData.icontravel,
              width: 30,
            ),

            trailing: station == selectedStation
                ? const Icon(Icons.check, color: buttonColor)
                : null,

            onTap: () {
              onStationSelected(station);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}