import '../../domain/entities/emotion_entity.dart';

class EmotionModel extends EmotionEntity {
  EmotionModel({
    required String id,
    required String title,
    required String image,
    required List<SubEmotionModel> subEmotions,
  }) : super(
          id: id,
          title: title,
          image: image,
          subEmotions: subEmotions,
        );

  factory EmotionModel.fromJson(Map<String, dynamic> json) {
    return EmotionModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      subEmotions: (json['subEmotions'] as List)
          .map((e) => SubEmotionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'subEmotions': subEmotions.map((e) => (e as SubEmotionModel).toJson()).toList(),
    };
  }
}

class SubEmotionModel extends SubEmotionEntity {
  SubEmotionModel({
    required String id,
    required String title,
    bool isSelected = false,
  }) : super(
          id: id,
          title: title,
          isSelected: isSelected,
        );

  factory SubEmotionModel.fromJson(Map<String, dynamic> json) {
    return SubEmotionModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isSelected': isSelected,
    };
  }
} 