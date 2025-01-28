import 'package:dartz/dartz.dart';
import '../../core/failures/failures.dart';
import '../entities/emotion_entity.dart';
import '../entities/mood_entry_entity.dart';


abstract class MoodRepository {
  Future<Either<Failure, List<EmotionEntity>>> getEmotions();
  Future<Either<Failure, void>> saveMoodEntry(MoodEntryEntity entry);
} 