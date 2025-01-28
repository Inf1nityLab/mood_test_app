import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CustomSlider extends StatefulWidget {
  final String title;
  final double value;
  final ValueChanged<double> onChanged;

  const CustomSlider({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  bool _isPressed = false;
  final double _min = 0.0;
  final double _max = 100.0;

  @override
  Widget build(BuildContext context) {
    final double sliderWidth = MediaQuery.of(context).size.width * 0.9;
    final double thumbRadius = 12.0;
    final double normalizedValue = (widget.value - _min) / (_max - _min);
    final double thumbLeftPosition = normalizedValue * (sliderWidth - thumbRadius * 3.7);
    
    final Color trackColor = Colors.grey.shade300;
    final Color progressColor = _isPressed ? AppColors.primary : trackColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          height: 77,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                offset: const Offset(2, 4),
                blurRadius: 10.8,
                spreadRadius: 0,
              ),
            ]
          ),
          child: _buildSliderContent(
            sliderWidth: sliderWidth,
            thumbRadius: thumbRadius,
            thumbLeftPosition: thumbLeftPosition,
            trackColor: trackColor,
            progressColor: progressColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSliderContent({
    required double sliderWidth,
    required double thumbRadius,
    required double thumbLeftPosition,
    required Color trackColor,
    required Color progressColor,
  }) {
    return Stack(
      children: [
        _buildTicks(),
        const SizedBox(height: 10),
        _buildSlider(
          sliderWidth: sliderWidth,
          thumbRadius: thumbRadius,
          thumbLeftPosition: thumbLeftPosition,
          trackColor: trackColor,
          progressColor: progressColor,
        ),
        _buildLabels(),
      ],
    );
  }

  Widget _buildTicks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return Container(
          width: 2,
          height: 10,
          color: Colors.grey.shade400,
        );
      }),
    );
  }

  Widget _buildSlider({
    required double sliderWidth,
    required double thumbRadius,
    required double thumbLeftPosition,
    required Color trackColor,
    required Color progressColor,
  }) {
    return SizedBox(
      width: sliderWidth,
      height: 50,
      child: GestureDetector(
        onPanDown: (details) {
          setState(() => _isPressed = true);
          _updateValueByTap(details.localPosition.dx, sliderWidth, thumbRadius);
        },
        onPanUpdate: (details) {
          setState(() => _isPressed = true);
          _updateValueByDrag(details.localPosition.dx, sliderWidth, thumbRadius);
        },
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            _buildTrack(trackColor),
            _buildProgress(sliderWidth, thumbLeftPosition, thumbRadius, progressColor),
            _buildThumb(thumbLeftPosition, thumbRadius),
          ],
        ),
      ),
    );
  }

  Widget _buildTrack(Color trackColor) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }

  Widget _buildProgress(double sliderWidth, double thumbLeftPosition, double thumbRadius, Color progressColor) {
    return Positioned(
      left: 0,
      right: sliderWidth - thumbLeftPosition - thumbRadius * 2,
      child: Container(
        height: 6,
        decoration: BoxDecoration(
          color: progressColor,
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }

  Widget _buildThumb(double thumbLeftPosition, double thumbRadius) {
    return Positioned(
      left: thumbLeftPosition,
      child: CircleAvatar(
        radius: thumbRadius,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: thumbRadius - 6,
          backgroundColor: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildLabels() {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Низкий',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFF919EAB),
            ),
          ),
          Text(
            'Высокий',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFF919EAB),
            ),
          ),
        ],
      ),
    );
  }

  void _updateValueByTap(double localDx, double width, double radius) {
    final newValue = _getValueFromPosition(localDx, width, radius).clamp(_min, _max);
    widget.onChanged(newValue);
  }

  void _updateValueByDrag(double localDx, double width, double radius) {
    final newValue = _getValueFromPosition(localDx, width, radius).clamp(_min, _max);
    widget.onChanged(newValue);
  }

  double _getValueFromPosition(double localDx, double width, double radius) {
    final double trackWidth = width - radius * 2;
    final double clampedDx = localDx.clamp(0, width);
    final double percent = (clampedDx - radius).clamp(0, trackWidth) / trackWidth;
    return percent * (_max - _min) + _min;
  }
} 