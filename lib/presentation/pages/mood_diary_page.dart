import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/emotion_entity.dart';
import '../bloc/mood_bloc.dart';
import '../widgets/custom_slider.dart';
import '../widgets/emotions_grid.dart';
import 'package:collection/collection.dart';

class MoodDiaryPage extends StatefulWidget {
  const MoodDiaryPage({super.key});

  @override
  State<MoodDiaryPage> createState() => _MoodDiaryPageState();
}

class _MoodDiaryPageState extends State<MoodDiaryPage> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (context, state) {
        if (state is! EmotionsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final selectedEmotion = state.selectedEmotionId != null
            ? state.emotions.firstWhere((e) => e.id == state.selectedEmotionId)
            : null;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              _buildSectionTitle('Что ты чувствуешь?'),
              EmotionsGrid(
                emotions: state.emotions,
                selectedIndex: state.selectedEmotionId != null
                    ? state.emotions.indexWhere((e) => e.id == state.selectedEmotionId)
                    : -1,
                onEmotionSelected: (index) {
                  context.read<MoodBloc>().add(
                    SelectEmotion(state.emotions[index].id),
                  );
                },
              ),
              if (selectedEmotion != null) _buildEmotionTags(state.emotions),
              const SizedBox(height: 36),
              CustomSlider(
                title: 'Уровень стресса',
                value: state.stressLevel,
                onChanged: (value) {
                  context.read<MoodBloc>().add(
                    UpdateStressLevel(value),
                  );
                },
              ),
              const SizedBox(height: 36),
              CustomSlider(
                title: 'Самооценка',
                value: state.selfEsteemLevel,
                onChanged: (value) {
                  context.read<MoodBloc>().add(
                    UpdateSelfEsteemLevel(value),
                  );
                },
              ),
              const SizedBox(height: 36),
              _buildSectionTitle('Заметки'),
              _buildNotesField(state),
              const SizedBox(height: 16),
              _buildSaveButton(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.text,
        ),
      ),
    );
  }

  Widget _buildEmotionTags(List<EmotionEntity> emotions) {
    final state = context.read<MoodBloc>().state;
    if (state is! EmotionsLoaded) {
      return const SizedBox.shrink();
    }

    final selectedEmotion = emotions.firstWhereOrNull((e) => e.id == state.selectedEmotionId);

    if (selectedEmotion == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: selectedEmotion.subEmotions.map((subEmotion) {
          final isSelected = subEmotion.id == state.selectedSubEmotionId;
          return GestureDetector(
            onTap: () {
              context.read<MoodBloc>().add(SelectSubEmotion(subEmotion.id));
            },
            child: Container(
              height: 21,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(3),
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
                  color: isSelected ? AppColors.white : AppColors.text,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotesField(EmotionsLoaded state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            offset: const Offset(2, 4),
            blurRadius: 10.8,
          ),
        ],
      ),
      child: TextField(
        controller: _noteController,
        maxLines: 4,
        onChanged: (value) {
          context.read<MoodBloc>().add(UpdateNote(value));
        },
        style: const TextStyle(
          color: AppColors.text,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'Напишите свои мысли...',
          hintStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color(0xFF919EAB),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide.none,
          ),
          fillColor: AppColors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget _buildSaveButton(EmotionsLoaded state) {
    final bool isValid = state.selectedEmotionId != null &&
        state.selectedSubEmotionId != null &&
        state.stressLevel >= 0 &&
        state.selfEsteemLevel >= 0 &&
        (state.note?.isNotEmpty ?? false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 44,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isValid
              ? () {
                  context.read<MoodBloc>().add(SaveMoodEntry());
                  _noteController.clear();
                  _showSuccessDialog();
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isValid ? AppColors.primary : Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(69),
            ),
          ),
          child: Text(
            'Сохранить',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: isValid ? Colors.white : Colors.grey.shade500,
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 50,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Сохранено!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Ваша запись успешно сохранена',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(69),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 