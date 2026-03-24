// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:enr_tickets/features/home/data/model/model.dart';
import 'package:meta/meta.dart';

part 'search_result_state.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultCubit() : super(SearchResultInitial());

  Future<void> fetchResults({
    required String classType,
    required int trainNumber,
    required int stops,

    required String from,
    required String to,
    required String departTime,
    required String arriveTime,
    required DateTime departDate,
    required String arriveDate,
    required String duration,
    required int availableTickets,
    required List<String> stopeStations,
  }) async {
    try {
      emit(SearchResultLoading());

      // محاكاة جلب بيانات من API
      await Future.delayed(Duration(seconds: 5));

      final trains = <TrainInfo>[
        TrainInfo(
          trainNumber: trainNumber, //comaing from api
          availableTickets: availableTickets, //comaing from api
          stops: stops, //comaing from api
          classType: classType, //comaing from api
          fromStation: from, //local 
          toStation: to,      //local
          departTime: departTime, //comaing from api
          arriveTime: arriveTime, //comaing from api
          departDate: departDate, //comaing from api
          arriveDate: arriveDate, //comaing from api
          duration: duration, //comaing from api
          stopeStations: stopeStations, //comaing from api
        ),
      ];

      emit(SearchResultSuccess(trains: trains));
    } catch (e) {
      emit(SearchResultFailure(errorMessage: e.toString()));
    }
  }
}
