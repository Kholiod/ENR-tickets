// ignore_for_file: file_names

enum SeatStatus { available, selected, booked }

class SeatModel {
  final int number;
  final SeatStatus status;

  SeatModel({
    required this.number,
    required this.status,
  });

  SeatModel copyWith({SeatStatus? status}) {
    return SeatModel(
      number: number,
      status: status ?? this.status,
    );
  }
}