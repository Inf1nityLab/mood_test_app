import 'package:flutter/material.dart';
import 'package:mood_tracker/presentation/pages/calendar_page.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/custom_tab_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mood_bloc.dart';
import 'statistics_page.dart';
import '../bloc/time_bloc.dart';
import 'mood_diary_page.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      title: BlocBuilder<TimeBloc, TimeState>(
        builder: (context, state) {
          return Text(
            state.currentDateTime,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFFBCBCBF),
            ),
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const FullScreenCalendar(),),);
          },
          icon: const Icon(
            Icons.calendar_month,
            color: Color(0xFFBCBCBF),
          ),
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: CustomTabBar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (context, state) {
        if (state is MoodLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (state is MoodError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        
        if (state is EmotionsLoaded) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: AppColors.background,
              appBar: _buildAppBar(),
              body: const TabBarView(
                children: [
                  MoodDiaryPage(),
                  StatisticsPage(),
                ],
              ),
            ),
          );
        }
        
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
} 