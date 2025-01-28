import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/emotion_entity.dart';
import '../../domain/entities/mood_entry_entity.dart';
import '../../domain/usecases/get_emotions_usecase.dart';
import '../../domain/usecases/save_mood_entry_usecase.dart';
import '../../data/models/mood_entry_model.dart';

part 'mood_event.dart';
part 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final GetEmotionsUseCase getEmotions;
  final SaveMoodEntryUseCase saveMoodEntry;

  MoodBloc({
    required this.getEmotions,
    required this.saveMoodEntry,
  }) : super(MoodInitial()) {
    on<LoadEmotions>(_onLoadEmotions);
    on<SelectEmotion>(_onSelectEmotion);
    on<SelectSubEmotion>(_onSelectSubEmotion);
    on<UpdateStressLevel>(_onUpdateStressLevel);
    on<UpdateSelfEsteemLevel>(_onUpdateSelfEsteemLevel);
    on<UpdateNote>(_onUpdateNote);
    on<SaveMoodEntry>(_onSaveMoodEntry);
  }

  Future<void> _onLoadEmotions(LoadEmotions event, Emitter<MoodState> emit) async {
    emit(MoodLoading());
    final result = await getEmotions();
    result.fold(
      (failure) => emit(MoodError(failure.message)),
      (emotions) => emit(EmotionsLoaded(emotions)),
    );
  }

  void _onSelectEmotion(SelectEmotion event, Emitter<MoodState> emit) {
    if (state is EmotionsLoaded) {
      final currentState = state as EmotionsLoaded;
      emit(currentState.copyWith(selectedEmotionId: event.emotionId));
    }
  }

  void _onSelectSubEmotion(SelectSubEmotion event, Emitter<MoodState> emit) {
    if (state is EmotionsLoaded) {
      final currentState = state as EmotionsLoaded;
      emit(currentState.copyWith(selectedSubEmotionId: event.subEmotionId));
    }
  }

  void _onUpdateStressLevel(UpdateStressLevel event, Emitter<MoodState> emit) {
    if (state is EmotionsLoaded) {
      final currentState = state as EmotionsLoaded;
      emit(currentState.copyWith(stressLevel: event.level));
    }
  }

  void _onUpdateSelfEsteemLevel(UpdateSelfEsteemLevel event, Emitter<MoodState> emit) {
    if (state is EmotionsLoaded) {
      final currentState = state as EmotionsLoaded;
      emit(currentState.copyWith(selfEsteemLevel: event.level));
    }
  }

  void _onUpdateNote(UpdateNote event, Emitter<MoodState> emit) {
    if (state is EmotionsLoaded) {
      final currentState = state as EmotionsLoaded;
      emit(currentState.copyWith(note: event.note));
    }
  }

  Future<void> _onSaveMoodEntry(SaveMoodEntry event, Emitter<MoodState> emit) async {
    if (state is EmotionsLoaded) {
      final currentState = state as EmotionsLoaded;
      if (!currentState.isValid) {
        emit(MoodError('Пожалуйста, заполните все поля'));
        return;
      }

      final selectedEmotion = currentState.emotions.firstWhere(
        (e) => e.id == currentState.selectedEmotionId,
      );

      final selectedSubEmotion = selectedEmotion.subEmotions.firstWhere(
        (e) => e.id == currentState.selectedSubEmotionId,
      );

      final entry = MoodEntryModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        dateTime: DateTime.now(),
        selectedEmotion: selectedEmotion,
        selectedSubEmotion: selectedSubEmotion,
        stressLevel: currentState.stressLevel,
        selfEsteemLevel: currentState.selfEsteemLevel,
        note: currentState.note,
      );

      final result = await saveMoodEntry(entry);
      result.fold(
        (failure) => emit(MoodError(failure.message)),
        (_) {
          emit(EmotionsLoaded(
            currentState.emotions,
            selectedEmotionId: null,
            selectedSubEmotionId: null,
            stressLevel: 50.0,
            selfEsteemLevel: 50.0,
            note: null,
          ));
        },
      );
    }
  }
} 