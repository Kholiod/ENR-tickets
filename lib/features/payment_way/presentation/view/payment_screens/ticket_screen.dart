import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketScreen extends StatelessWidget {
  final String from;
  final String to;
  final String train;
  final String seat;
  final String time;
  final String name;

  const TicketScreen({
    super.key,
    required this.from,
    required this.to,
    required this.train,
    required this.seat,
    required this.time,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    String qrData =
        """
From: $from
To: $to
Train: $train
Seat: $seat
Time: $time
Passenger: $name
""";

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Your Ticket"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          width: 320,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 🔴 Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const Text(
                      "ENR Ticket",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          from,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.arrow_forward, color: Colors.white),
                        Text(
                          to,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// ✂️ dashed line
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DashedLine(),
              ),

              /// QR
              Padding(
                padding: const EdgeInsets.all(16),
                child: QrImageView(data: qrData, size: 200),
              ),

              /// ✂️ dashed line تاني
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DashedLine(),
              ),

              const SizedBox(height: 10),

              /// Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Train: $train"), Text("Seat: $seat")],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Passenger: $name",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 🔥 Download Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Download coming soon 🔥")),
                    );
                  },
                  icon: const Icon(Icons.download),
                  label: const Text("Download Ticket"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// dashed line widget
class DashedLine extends StatelessWidget {
  const DashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double dashWidth = 6;
        double dashSpace = 4;
        int count = (constraints.constrainWidth() / (dashWidth + dashSpace))
            .floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(count, (_) {
            return Container(width: dashWidth, height: 1, color: Colors.grey);
          }),
        );
      },
    );
  }
}
