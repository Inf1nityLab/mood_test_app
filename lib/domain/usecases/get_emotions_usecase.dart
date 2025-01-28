import 'package:dartz/dartz.dart';
import '../../core/failures/failures.dart';
import '../entities/emotion_entity.dart';
import '../repositories/mood_repository.dart';

class GetEmotionsUseCase {
  final MoodRepository repository;

  GetEmotionsUseCase(this.repository);

  Future<Either<Failure, List<EmotionEntity>>> call() {
    return repository.getEmotions();
  }
} 