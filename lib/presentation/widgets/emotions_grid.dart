import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/emotion_entity.dart';

class EmotionsGrid extends StatelessWidget {
  final List<EmotionEntity> emotions;
  final int selectedIndex;
  final ValueChanged<int> onEmotionSelected;

  const EmotionsGrid({
    super.key,
    required this.emotions,
    required this.selectedIndex,
    required this.onEmotionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: ListView.builder(
        itemCount: emotions.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = emotions[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onEmotionSelected(index),
            child: Container(
              height: 118,
              width: 83,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                left: index == 0 ? 20 : 0,
                right: 12,
                bottom: 2.5,
                top: 2.5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(76),
                color: AppColors.white,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    item.image,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 