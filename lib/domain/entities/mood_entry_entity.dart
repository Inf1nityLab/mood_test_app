import 'package:equatable/equatable.dart';

import 'emotion_entity.dart';

class MoodEntryEntity extends Equatable {
  final String id;
  final DateTime dateTime;
  final EmotionEntity selectedEmotion;
  final SubEmotionEntity? selectedSubEmotion;
  final double stressLevel;
  final double selfEsteemLevel;
  final String? note;

  const MoodEntryEntity({
    required this.id,
    required this.dateTime,
    required this.selectedEmotion,
    this.selectedSubEmotion,
    required this.stressLevel,
    required this.selfEsteemLevel,
    this.note,
  });

  bool get isValid =>
      selectedEmotion != null &&
      selectedSubEmotion != null &&
      stressLevel >= 0 &&
      selfEsteemLevel >= 0;

  @override
  List<Object?> get props => [
        id,
        dateTime,
        selectedEmotion,
        selectedSubEmotion,
        stressLevel,
        selfEsteemLevel,
        note,
      ];
} 