class TrainInfo {
  final int trainNumber;
  final int availableTickets;
  final int stops;
  final String classType;
  final String fromStation;
  final String toStation;
  final String departTime;
  final String arriveTime;
  final DateTime departDate;
  final String arriveDate;
  final String duration;
  final List<String> stopeStations;

  TrainInfo({
    required this.trainNumber,
    required this.availableTickets,
    required this.stops,
    required this.classType,
    required this.fromStation,
    required this.toStation,
    required this.departTime,
    required this.arriveTime,
    required this.departDate,
    required this.arriveDate,
    required this.duration, required this.stopeStations,
  });
}