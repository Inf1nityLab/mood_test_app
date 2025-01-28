import 'package:equatable/equatable.dart';

class EmotionEntity extends Equatable {
  final String id;
  final String title;
  final String image;
  final List<SubEmotionEntity> subEmotions;

  const EmotionEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.subEmotions,
  });

  @override
  List<Object?> get props => [id, title, image, subEmotions];
}

class SubEmotionEntity extends Equatable {
  final String id;
  final String title;
  final bool isSelected;

  const SubEmotionEntity({
    required this.id,
    required this.title,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [id, title, isSelected];

  SubEmotionEntity copyWith({bool? isSelected}) {
    return SubEmotionEntity(
      id: id,
      title: title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
} 