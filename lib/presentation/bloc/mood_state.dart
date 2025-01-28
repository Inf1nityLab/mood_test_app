part of 'mood_bloc.dart';

abstract class MoodState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MoodInitial extends MoodState {}

class MoodLoading extends MoodState {}

class MoodError extends MoodState {
  final String message;

  MoodError(this.message);

  @override
  List<Object?> get props => [message];
}

class EmotionsLoaded extends MoodState {
  final List<EmotionEntity> emotions;
  final String? selectedEmotionId;
  final String? selectedSubEmotionId;
  final double stressLevel;
  final double selfEsteemLevel;
  final String? note;

  EmotionsLoaded(
    this.emotions, {
    this.selectedEmotionId,
    this.selectedSubEmotionId,
    this.stressLevel = 50.0,
    this.selfEsteemLevel = 50.0,
    this.note,
  });

  bool get isValid =>
      selectedEmotionId != null &&
      selectedSubEmotionId != null &&
      stressLevel >= 0 &&
      selfEsteemLevel >= 0;

  EmotionsLoaded copyWith({
    List<EmotionEntity>? emotions,
    String? selectedEmotionId,
    String? selectedSubEmotionId,
    double? stressLevel,
    double? selfEsteemLevel,
    String? note,
  }) {
    return EmotionsLoaded(
      emotions ?? this.emotions,
      selectedEmotionId: selectedEmotionId ?? this.selectedEmotionId,
      selectedSubEmotionId: selectedSubEmotionId ?? this.selectedSubEmotionId,
      stressLevel: stressLevel ?? this.stressLevel,
      selfEsteemLevel: selfEsteemLevel ?? this.selfEsteemLevel,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [
        emotions,
        selectedEmotionId,
        selectedSubEmotionId,
        stressLevel,
        selfEsteemLevel,
        note,
      ];
} 