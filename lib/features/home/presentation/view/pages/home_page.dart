import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/custom_button_register.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/home/presentation/state_mangement/home_cubit/home_cubit.dart';
import 'package:enr_tickets/features/home/presentation/view/pages/search_results_page.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/custom_home_logo.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/custom_selection_view.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/travel_date_card.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/trip_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeSearchSuccess) {
          /// ✅ الحل النهائي (بدون parameters)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchResultsPage()),
          );
        }

        if (state is HomeFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },

      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,

              body: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomHomeLogo(),

                    Text(headhomepage, style: Styles.textStyle27),

                    /// Stations
                    CustomSelectionView(
                      fromStation: cubit.fromStation,
                      toStation: cubit.toStation,
                      onStationsChanged: (from, to) {
                        cubit.updateStations(from, to);
                      },
                    ),

                    const Gap(40),

                    /// Travel Date
                    TravelDateCard(
                      title: travelDate,
                      date:
                          "${cubit.travelDate.day}/${cubit.travelDate.month}/${cubit.travelDate.year}",
                      onTap: () async {
                        DateTime now = DateTime.now();
                        DateTime cleanNow = DateTime(
                          now.year,
                          now.month,
                          now.day,
                        );

                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: cubit.travelDate,
                          firstDate: cleanNow,
                          lastDate: cleanNow.add(const Duration(days: 18)),
                        );

                        if (pickedDate != null) {
                          cubit.updateDate(pickedDate);
                        }
                      },
                    ),

                    const Gap(20),

                    /// Trip Type
                    TripTypeSelector(
                      selectedType: cubit.tripType,
                      onChanged: (value) {
                        cubit.updateTripType(value);
                      },
                    ),

                    /// 🔍 Search Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: VerifyButton(
                        title: "Search",
                        onTap: () {
                          context.read<HomeCubit>().searchTrip();
                        },
                      ),
                    ),

                    const Gap(20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
