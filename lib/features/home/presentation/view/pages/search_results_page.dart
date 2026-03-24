import 'package:enr_tickets/features/home/presentation/state_mangement/search_result_cubit/search_result_cubit.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/search_results_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultsPage extends StatelessWidget {
  final int trainNumber;
  final int availableTickets;
  final int stops;
  final String classType;
  final String departTime;
  final String arriveTime;
  final DateTime departDate;
  final String arriveDate;
  final String duration;
  final String from;
  final String to;
  final List<String> stopStations;
  const SearchResultsPage({
    super.key,
    required this.from,
    required this.to,
    required this.trainNumber,
    required this.availableTickets,
    required this.stops,
    required this.classType,
    required this.departTime,
    required this.arriveTime,
    required this.departDate,
    required this.arriveDate,
    required this.duration,
    required this.stopStations,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchResultCubit()
        ..fetchResults(
          stops: stops,
          trainNumber: trainNumber,
          stopeStations: stopStations,
          classType: classType,
          from: from,
          to: to,
          departTime: departTime,
          arriveTime: arriveTime,
          departDate: departDate,
          arriveDate: arriveDate,
          duration: duration,
          availableTickets: availableTickets,
        ),
      child: SearchResultsBody(
        stopeStation: stopStations,
        fromStation: from,
        toStation: to,
        trainNumber: trainNumber,
        availableTickets: availableTickets,
        stops: stops,
        classType: classType,
        departTime: departTime,
        arriveTime: arriveTime,
        departDate: departDate,
        arriveDate: arriveDate,
        duration: duration,
      ),
    );
  }
}
