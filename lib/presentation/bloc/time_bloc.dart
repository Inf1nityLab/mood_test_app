import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  Timer? _timer;

  TimeBloc() : super(TimeState(currentDateTime: _formatDateTime(DateTime.now()))) {
    on<StartTimer>(_onStartTimer);
    on<UpdateTime>(_onUpdateTime);

    add(StartTimer());
  }

  void _onStartTimer(StartTimer event, Emitter<TimeState> emit) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      add(UpdateTime());
    });
    add(UpdateTime());
  }

  void _onUpdateTime(UpdateTime event, Emitter<TimeState> emit) {
    emit(TimeState(currentDateTime: _formatDateTime(DateTime.now())));
  }

  static String _formatDateTime(DateTime dateTime) {
    final months = [
      'январь', 'февраль', 'март', 'апрель', 'май', 'июнь',
      'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь'
    ];
    
    final day = dateTime.day;
    final month = months[dateTime.month - 1];
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    
    return '$day $month $hour:$minute';
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
} 