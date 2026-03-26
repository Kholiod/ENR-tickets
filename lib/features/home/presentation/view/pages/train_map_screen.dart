import 'package:flutter/material.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/seat_page.dart';

class TrainMapScreen extends StatelessWidget {
  final int trainNumber;
  final String trainType;

  const TrainMapScreen({
    super.key,
    required this.trainNumber,
    required this.trainType,
  });

  @override
  Widget build(BuildContext context) {
    int coaches = 10;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Train $trainNumber"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),

          /// 🚆 ENGINE
          const Icon(Icons.train, size: 80, color: Colors.red),

          const SizedBox(height: 10),

          Text("Type: $trainType", style: const TextStyle(fontSize: 16)),

          const SizedBox(height: 20),

          const Text(
            "Select Coach",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: coaches,
              itemBuilder: (context, index) {
                int coach = index + 1;

                String coachType = "";
                int seatCount = 0;

                /// 🚆 Train 185 (روسي)
                if (trainNumber == 185) {
                  coachType = "ثالثة مكيفة";
                  seatCount = 88;
                }
                /// 🚆 Train 2009 (اسباني)
                else if (trainNumber == 2009) {
                  if (coach <= 3) {
                    coachType = "أولى اسباني";
                    seatCount = 47;
                  } else {
                    coachType = "تانية اسباني";
                    seatCount = 60;
                  }
                }
                /// 🚆 Train 2031 (تالجو)
                else if (trainNumber == 2031) {
                  if (coach <= 3) {
                    coachType = "أولى تالجو";
                    seatCount = 32;
                  } else {
                    coachType = "تانية تالجو";
                    seatCount = 44;
                  }
                }

                /// 🎨 تحديد اللون حسب النوع
                Color coachColor;

                if (coachType.contains("أولى")) {
                  coachColor = Colors.orange;
                } else if (coachType.contains("تانية")) {
                  coachColor = Colors.blue;
                } else {
                  coachColor = Colors.green;
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatPage(
                          trainNumber: trainNumber.toString(),
                          trainType: coachType,
                          coachNumber: coach,
                          seatCount: seatCount,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: 110,
                    decoration: BoxDecoration(
                      color: coachColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 6),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.airline_seat_recline_normal,
                          size: 30,
                          color: Colors.white,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Coach $coach",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          coachType,
                          style: const TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "$seatCount seats",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
