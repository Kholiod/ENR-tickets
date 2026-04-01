import 'package:enr_tickets/features/home/presentation/state_mangement/search_result_cubit/search_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/search_results_widgets/train_result_card.dart';

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

                  return TrainResultCard(train: train);
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
