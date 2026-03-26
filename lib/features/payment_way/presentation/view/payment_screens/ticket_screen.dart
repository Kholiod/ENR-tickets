import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:enr_tickets/core/utils/pdf_generator.dart';

class TicketScreen extends StatelessWidget {
  final String from;
  final String to;
  final String train;
  final String trainType;
  final String seat;
  final String coach;
  final String time;
  final String name;
  final String price;
  final String bookingType;
  final String ticketId;

  const TicketScreen({
    super.key,
    required this.from,
    required this.to,
    required this.train,
    required this.trainType,
    required this.seat,
    required this.coach,
    required this.time,
    required this.name,
    required this.price,
    required this.bookingType,
    required this.ticketId,
  });

  /// 🔥 PDF Download (متعدل)
  void _downloadTicket() async {
    await generateTicketPDF(
      from: from,
      to: to,
      train: train,
      coach: coach,
      seat: seat,
      name: name,
      price: price,
      ticketId: ticketId,
      trainType: trainType,
      bookingType: bookingType,
    );
  }

  /// 🔥 Share
  void _shareTicket() {
    Share.share(
      "🚆 ENR Ticket\n\n"
      "ID: $ticketId\n"
      "Train: $train\n"
      "Coach: $coach\n"
      "From: $from → $to\n"
      "Seat: $seat\n"
      "Price: $price EGP\n"
      "Passenger: $name",
    );
  }

  @override
  Widget build(BuildContext context) {
    final qrData =
        """
ID: $ticketId
Train: $train
Coach: $coach
Seat: $seat
From: $from
To: $to
""";

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text("Your Ticket"),
        actions: [
          IconButton(onPressed: _shareTicket, icon: const Icon(Icons.share)),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 20),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// 🔴 HEADER
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "ENR Ticket | تذكرة القطار",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _stationText(from),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            _stationText(to),
                          ],
                        ),

                        const SizedBox(height: 5),
                        Text(
                          time,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: DashedLine(),
                  ),

                  /// 🔲 QR
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        QrImageView(data: qrData, size: 160),
                        const SizedBox(height: 8),
                        Text(
                          "ID: $ticketId",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: DashedLine(),
                  ),

                  const SizedBox(height: 10),

                  /// 📋 INFO
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _infoRow("Train", "القطار", train),
                        _infoRow("Type", "نوع القطار", trainType),
                        _infoRow("Coach", "العربة", coach),
                        _infoRow("Seat", "المقعد", seat),
                        _infoRow("Booking", "نوع الحجز", bookingType),
                        _infoRow("Price", "السعر", "$price EGP"),
                        const SizedBox(height: 10),
                        _infoRow("Passenger", "الراكب", name),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🔥 BUTTONS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _downloadTicket,
                            icon: const Icon(Icons.download),
                            label: const Text("Download"),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _shareTicket,
                            icon: const Icon(Icons.share),
                            label: const Text("Share"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _stationText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _infoRow(String en, String ar, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              en,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              ar,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLine extends StatelessWidget {
  const DashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 6.0;
        final dashSpace = 4.0;
        final count = (constraints.maxWidth / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(count, (_) {
            return Container(
              width: dashWidth,
              height: 1.2,
              color: Colors.grey.shade400,
            );
          }),
        );
      },
    );
  }
}
