import '../../domain/entities/mood_entry_entity.dart';
import '../../domain/entities/emotion_entity.dart';
import 'emotion_model.dart';

class MoodEntryModel extends MoodEntryEntity {
  MoodEntryModel({
    required String id,
    required DateTime dateTime,
    required EmotionEntity selectedEmotion,
    SubEmotionEntity? selectedSubEmotion,
    required double stressLevel,
    required double selfEsteemLevel,
    String? note,
  }) : super(
          id: id,
          dateTime: dateTime,
          selectedEmotion: selectedEmotion,
          selectedSubEmotion: selectedSubEmotion,
          stressLevel: stressLevel,
          selfEsteemLevel: selfEsteemLevel,
          note: note,
        );

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) {
    return MoodEntryModel(
      id: json['id'],
      dateTime: DateTime.parse(json['dateTime']),
      selectedEmotion: EmotionModel.fromJson(json['selectedEmotion']),
      selectedSubEmotion: json['selectedSubEmotion'] != null
          ? SubEmotionModel.fromJson(json['selectedSubEmotion'])
          : null,
      stressLevel: json['stressLevel'].toDouble(),
      selfEsteemLevel: json['selfEsteemLevel'].toDouble(),
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'selectedEmotion': (selectedEmotion as EmotionModel).toJson(),
      'selectedSubEmotion': selectedSubEmotion != null
          ? (selectedSubEmotion as SubEmotionModel).toJson()
          : null,
      'stressLevel': stressLevel,
      'selfEsteemLevel': selfEsteemLevel,
      'note': note,
    };
  }
} 