part of 'mood_bloc.dart';

abstract class MoodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEmotions extends MoodEvent {}

class SelectEmotion extends MoodEvent {
  final String emotionId;

  SelectEmotion(this.emotionId);

  @override
  List<Object?> get props => [emotionId];
}

class SelectSubEmotion extends MoodEvent {
  final String subEmotionId;

  SelectSubEmotion(this.subEmotionId);

  @override
  List<Object?> get props => [subEmotionId];
}

class UpdateStressLevel extends MoodEvent {
  final double level;

  UpdateStressLevel(this.level);

  @override
  List<Object?> get props => [level];
}

class UpdateSelfEsteemLevel extends MoodEvent {
  final double level;

  UpdateSelfEsteemLevel(this.level);

  @override
  List<Object?> get props => [level];
}

class UpdateNote extends MoodEvent {
  final String note;

  UpdateNote(this.note);

  @override
  List<Object?> get props => [note];
}

class SaveMoodEntry extends MoodEvent {}

// Другие события... 