// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:enr_tickets/features/home/data/model/model.dart';
import 'package:meta/meta.dart';

part 'search_result_state.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultCubit() : super(SearchResultInitial());

  Future<void> fetchResults() async {
    try {
      emit(SearchResultLoading());

      await Future.delayed(const Duration(seconds: 1));

      final trains = <TrainInfo>[
        TrainInfo(
          trainNumber: 185,
          trainName: "روسي مكيف",
          availableTickets: 32,
          stops: 9,
          classType: "ثالثة مكيفة",
          fromStation: "Cairo",
          toStation: "Sohag",
          departTime: "00:05",
          arriveTime: "08:45",
          departDate: DateTime.now(),
          arriveDate: "Today",
          duration: "8h",
          stopeStations: [
            "Cairo",
            "Giza",
            "Beni Suef",
            "Minya",
            "Asyut",
            "Sohag",
          ],
        ),

        TrainInfo(
          trainNumber: 2009,
          trainName: "أولى/تانية اسباني مطور",
          availableTickets: 13,
          stops: 4,
          classType: "أولى + تانية",
          fromStation: "Cairo",
          toStation: "Sohag",
          departTime: "02:35",
          arriveTime: "06:40",
          departDate: DateTime.now(),
          arriveDate: "Today",
          duration: "4h",
          stopeStations: [
            "Cairo",
            "Giza",
            "Beni Suef",
            "Minya",
            "Asyut",
            "Sohag",
          ],
        ),

        TrainInfo(
          trainNumber: 2031,
          trainName: "أولى/تانية تالجو",
          availableTickets: 4,
          stops: 6,
          classType: "أولى + تانية",
          fromStation: "Cairo",
          toStation: "Sohag",
          departTime: "00:45",
          arriveTime: "07:05",
          departDate: DateTime.now(),
          arriveDate: "Today",
          duration: "6h",
          stopeStations: [
            "Cairo",
            "Giza",
            "Beni Suef",
            "Minya",
            "Asyut",
            "Sohag",
          ],
        ),
      ];

      emit(SearchResultSuccess(trains: trains));
    } catch (e) {
      emit(SearchResultFailure(errorMessage: e.toString()));
    }
  }
}
