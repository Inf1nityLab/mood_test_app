import 'package:dartz/dartz.dart';
import '../../core/failures/failures.dart';
import '../entities/mood_entry_entity.dart';
import '../repositories/mood_repository.dart';

class SaveMoodEntryUseCase {
  final MoodRepository repository;

  SaveMoodEntryUseCase(this.repository);

  Future<Either<Failure, void>> call(MoodEntryEntity entry) {
    return repository.saveMoodEntry(entry);
  }
} 