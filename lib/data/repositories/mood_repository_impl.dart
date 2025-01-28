import 'package:dartz/dartz.dart';
import '../../core/failures/failures.dart';
import '../../domain/entities/emotion_entity.dart';
import '../../domain/entities/mood_entry_entity.dart';
import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_local_data_source.dart';
import '../models/mood_entry_model.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodLocalDataSource localDataSource;

  MoodRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<EmotionEntity>>> getEmotions() async {
    try {
      final emotions = await localDataSource.getEmotions();
      return Right(emotions);
    } catch (e) {
      return Left(CacheFailure('Не удалось загрузить эмоции'));
    }
  }

  @override
  Future<Either<Failure, void>> saveMoodEntry(MoodEntryEntity entry) async {
    try {
      await localDataSource.saveMoodEntry(entry as MoodEntryModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Не удалось сохранить запись'));
    }
  }
} 