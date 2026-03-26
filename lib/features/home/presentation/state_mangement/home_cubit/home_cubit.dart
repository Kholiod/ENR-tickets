// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  /// Stations list
  List<String> stations = [];

  /// Stop Stations
  List<String> stopStations = [
    "Cairo",
    "Giza",
    "Beni Suef",
    "Maghagha",
    "Minya",
    "Malawi",
    "Deirut",
    "Asyut",
    "Tema",
    "Tahta",
    "Sohag",
    "Gerga",
  ];

  /// Selected Data
  String fromStation = "From Station";
  String toStation = "To Station";
  String tripType = "roundTrip";
  DateTime travelDate = DateTime.now();

  /// Load Stations
  Future<void> getStations() async {
    try {
      emit(HomeLoading());

      await Future.delayed(const Duration(seconds: 2));

      stations = [
        "Cairo",
        "Giza",
        "Alexandria",
        "Tanta",
        "Mansoura",
        "Assiut",
        "Sohag",
        "Qena",
        "Luxor",
        "Aswan",
      ];

      /// 🔥 بدل HomeSuccess
      emit(HomeInitial());
    } catch (e) {
      emit(HomeFailure(errorMessage: e.toString()));
    }
  }

  /// Update Stations
  void updateStations(String from, String to) {
    fromStation = from;
    toStation = to;

    /// 🔥 بدل HomeSuccess
    emit(HomeInitial());
  }

  /// Update Date
  void updateDate(DateTime date) {
    travelDate = date;

    /// 🔥 بدل HomeSuccess
    emit(HomeInitial());
  }

  /// Update Trip Type
  void updateTripType(String type) {
    tripType = type;

    /// 🔥 بدل HomeSuccess
    emit(HomeInitial());
  }

  /// Search Trip
  void searchTrip() {
    if (fromStation == "From Station" || toStation == "To Station") {
      emit(HomeFailure(errorMessage: "Please choose stations correctly"));
      return;
    }

    emit(
      HomeSearchSuccess(
        from: fromStation,
        to: toStation,
        date: travelDate,
        stopStation: stopStations,
      ),
    );
  }
}
