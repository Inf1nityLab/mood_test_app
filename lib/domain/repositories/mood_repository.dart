import 'package:dartz/dartz.dart';
import '../entities/emotion_entity.dart';
import '../entities/mood_entry_entity.dart';
import '../failures/failures.dart';

abstract class MoodRepository {
  Future<Either<Failure, List<EmotionEntity>>> getEmotions();
  Future<Either<Failure, void>> saveMoodEntry(MoodEntryEntity entry);
} 