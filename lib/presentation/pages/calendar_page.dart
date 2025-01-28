import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/core/constants/app_colors.dart';

class FullScreenCalendar extends StatefulWidget {
  const FullScreenCalendar({super.key});

  @override
  State<FullScreenCalendar> createState() => _FullScreenCalendarState();
}

class _FullScreenCalendarState extends State<FullScreenCalendar> {
  List<DateTime?> selectedDates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.tabBackground,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.clear, color: AppColors.secondaryText,),),
      ),
      body: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarViewMode: CalendarDatePicker2Mode.scroll, // Режим скроллинга
          firstDate: DateTime(2020), // Самая ранняя дата
          lastDate: DateTime(2030), // Самая поздняя дата
          weekdayLabels: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'], // Дни недели на русском
          firstDayOfWeek: 1, // Первый день недели - Понедельник
          selectedDayHighlightColor: AppColors.primary, // Цвет выделенного дня
          dayTextStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ), // Текст дней
          selectedDayTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ), // Стиль выделенного дня
          hideScrollViewMonthWeekHeader: false,
          hideScrollViewTopHeader: true,
          // Расширить на весь экран
          // Стиль заголовка
        ),
        value: selectedDates,
        onValueChanged: (dates) {
          setState(() {
            selectedDates = dates;
          });
        },
      ),
    );
  }
}
