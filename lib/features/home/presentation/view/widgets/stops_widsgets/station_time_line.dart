import 'package:flutter/material.dart';

class StationTimeline extends StatelessWidget {
  final List<String> stations;

  const StationTimeline({super.key, required this.stations});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(stations.length, (index) {
        bool isFirst = index == 0;
        bool isLast = index == stations.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              width: 30,

              child: Column(
                children: [
                  if (!isFirst)
                    Container(width: 2, height: 20, color: Colors.blue),

                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),

                  if (!isLast)
                    Container(width: 2, height: 20, color: Colors.blue),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Padding(
              padding: const EdgeInsets.only(bottom: 20),

              child: Text(
                stations[index],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      }),
    );
  }
}
