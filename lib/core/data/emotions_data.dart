import '../constants/app_assets.dart';
import '../models/emotion.dart';

final List<Emotion> emotionsData = [
  Emotion(
    title: 'Радость', 
    image: AppAssets.joy,
    emotions: [
      "Радость", "Грусть", "Гнев", "Страх", "Удивление",
      "Отвращение", "Любовь", "Счастье", "Восторг",
      "Эйфория", "Обида", "Удовлетворение"
    ]
  ),
  Emotion(title: 'Страх', image: AppAssets.fear, emotions: ['']),
  Emotion(title: 'Бешенство', image: AppAssets.rabies, emotions: ['']),
  Emotion(title: 'Грусть', image: AppAssets.sadness, emotions: ['']),
  Emotion(title: 'Спокойствие', image: AppAssets.calm, emotions: ['']),
  Emotion(title: 'Сила', image: AppAssets.power, emotions: ['']),
]; 