import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/emotion_entity.dart';

class SubEmotionsGrid extends StatelessWidget {
  final List<SubEmotionEntity> subEmotions;
  final String? selectedSubEmotionId;
  final ValueChanged<String> onSubEmotionSelected;

  const SubEmotionsGrid({
    super.key,
    required this.subEmotions,
    required this.selectedSubEmotionId,
    required this.onSubEmotionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: subEmotions.map((subEmotion) {
          final isSelected = subEmotion.id == selectedSubEmotionId;
          return GestureDetector(
            onTap: () => onSubEmotionSelected(subEmotion.id),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    offset: const Offset(2, 4),
                    blurRadius: 10.8,
                  ),
                ],
              ),
              child: Text(
                subEmotion.title,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.text,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
} 