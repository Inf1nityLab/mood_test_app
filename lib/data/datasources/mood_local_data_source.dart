import '../models/emotion_model.dart';
import '../models/mood_entry_model.dart';

abstract class MoodLocalDataSource {
  Future<List<EmotionModel>> getEmotions();
  Future<void> saveMoodEntry(MoodEntryModel entry);
}

class MoodLocalDataSourceImpl implements MoodLocalDataSource {
  final List<MoodEntryModel> _entries = [];

  @override
  Future<List<EmotionModel>> getEmotions() async {
    return [
      EmotionModel(
        id: '1',
        title: 'Радость',
        image: 'assets/images/joy.png',
        subEmotions: [
          SubEmotionModel(id: '1_1', title: 'Возбуждение'),
          SubEmotionModel(id: '1_2', title: 'Восторг'),
          SubEmotionModel(id: '1_3', title: 'Игривость'),
          SubEmotionModel(id: '1_4', title: 'Наслаждение'),
          SubEmotionModel(id: '1_5', title: 'Очарование'),
          SubEmotionModel(id: '1_6', title: 'Осознанность'),
          SubEmotionModel(id: '1_7', title: 'Смелость'),
          SubEmotionModel(id: '1_8', title: 'Удоволствие'),
          SubEmotionModel(id: '1_9', title: 'Чувственность'),
          SubEmotionModel(id: '1_10', title: 'Энергичность'),
          SubEmotionModel(id: '1_11', title: 'Экстравагантность'),
        ],
      ),
      EmotionModel(
        id: '2',
        title: 'Страх',
        image: 'assets/images/fear.png',
        subEmotions: [
          SubEmotionModel(id: '2_1', title: 'Тревога'),
          SubEmotionModel(id: '2_2', title: 'Паника'),
          SubEmotionModel(id: '2_3', title: 'Ужас'),
        ],
      ),
      EmotionModel(
        id: '3',
        title: 'Бешенство',
        image: 'assets/images/rabies.png',
        subEmotions: [
          SubEmotionModel(id: '3_1', title: 'Гнев'),
          SubEmotionModel(id: '3_2', title: 'Ярость'),
          SubEmotionModel(id: '3_3', title: 'Раздражение'),
        ],
      ),
      EmotionModel(
        id: '4',
        title: 'Грусть',
        image: 'assets/images/sadness.png',
        subEmotions: [
          SubEmotionModel(id: '4_1', title: 'Тоска'),
          SubEmotionModel(id: '4_2', title: 'Печаль'),
          SubEmotionModel(id: '4_3', title: 'Уныние'),
        ],
      ),
      EmotionModel(
        id: '5',
        title: 'Спокойствие',
        image: 'assets/images/calm.png',
        subEmotions: [
          SubEmotionModel(id: '5_1', title: 'Умиротворение'),
          SubEmotionModel(id: '5_2', title: 'Безмятежность'),
          SubEmotionModel(id: '5_3', title: 'Расслабленность'),
        ],
      ),
      EmotionModel(
        id: '6',
        title: 'Сила',
        image: 'assets/images/power.png',
        subEmotions: [
          SubEmotionModel(id: '6_1', title: 'Уверенность'),
          SubEmotionModel(id: '6_2', title: 'Мощь'),
          SubEmotionModel(id: '6_3', title: 'Энергичность'),
        ],
      ),
    ];
  }

  @override
  Future<void> saveMoodEntry(MoodEntryModel entry) async {
    _entries.add(entry);
  }
} 