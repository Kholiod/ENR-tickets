import 'package:enr_tickets/features/home/presentation/state_mangement/search_result_cubit/search_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enr_tickets/features/home/presentation/view/pages/train_map_screen.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchResultCubit()..fetchResults(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text("Search Results"),
          centerTitle: true,
        ),

        body: BlocBuilder<SearchResultCubit, SearchResultState>(
          builder: (context, state) {
            if (state is SearchResultLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SearchResultFailure) {
              return Center(child: Text(state.errorMessage));
            }

            if (state is SearchResultSuccess) {
              final trains = state.trains;

              return ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: trains.length,
                itemBuilder: (context, index) {
                  final train = trains[index];

                  return Card(
                    elevation: 5,
                    shadowColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(bottom: 18),

                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🚆 HEADER
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Train ${train.trainNumber}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                train.trainName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  train.classType,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          const Divider(),

                          /// ⏱ TIMES
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(train.fromStation),
                                  Text(
                                    train.departTime,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                children: const [
                                  Icon(Icons.train, color: Colors.red),
                                  Text("------"),
                                ],
                              ),

                              Column(
                                children: [
                                  Text(train.toStation),
                                  Text(
                                    train.arriveTime,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          /// 🎟 SEATS + BUTTON
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${train.availableTickets} Seats",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TrainMapScreen(
                                        trainNumber: train.trainNumber,
                                        trainType: train.classType,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Book Now"),
                              ),
                            ],
                          ),

                          /// 📍 STOPS
                          ExpansionTile(
                            tilePadding: EdgeInsets.zero,
                            title: Text(
                              "+${train.stops} Stops",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 1, 3, 122),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: StationTimeline(
                                  stations: train.stopeStations,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

/// 🔵 STATION TIMELINE
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
                    Container(width: 2, height: 20, color: Colors.red),

                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),

                  if (!isLast)
                    Container(width: 2, height: 20, color: Colors.red),
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
