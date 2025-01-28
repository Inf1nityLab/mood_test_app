import 'package:get_it/get_it.dart';
import 'domain/repositories/mood_repository.dart';
import 'domain/usecases/get_emotions_usecase.dart';
import 'domain/usecases/save_mood_entry_usecase.dart';
import 'presentation/bloc/mood_bloc.dart';
import 'data/datasources/mood_local_data_source.dart';
import 'data/repositories/mood_repository_impl.dart';
import 'presentation/bloc/tab_bloc.dart';
import 'presentation/bloc/time_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data sources
  sl.registerLazySingleton<MoodLocalDataSource>(
    () => MoodLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<MoodRepository>(
    () => MoodRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetEmotionsUseCase(sl()));
  sl.registerLazySingleton(() => SaveMoodEntryUseCase(sl()));

  // Bloc
  sl.registerFactory(() => TimeBloc());
  sl.registerFactory(() => TabBloc());
  sl.registerFactory(
    () => MoodBloc(
      getEmotions: sl(),
      saveMoodEntry: sl(),
    ),
  );
} 