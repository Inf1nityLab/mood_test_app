import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../bloc/tab_bloc.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 43),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(47),
        color: AppColors.tabBackground,
      ),
      child: TabBar(
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        tabAlignment: TabAlignment.center,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.primary,
        ),
        dividerColor: AppColors.background,
        onTap: (index) {
          context.read<TabBloc>().add(TabChanged(index));
        },
        tabs: const [
          Tab(
            child: TabBarItem(
              icon: Icons.edit_note,
              text: 'Дневник настроения',
              index: 0,
            ),
          ),
          Tab(
            child: TabBarItem(
              icon: Icons.bar_chart,
              text: 'Статистика',
              index: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final int index;

  const TabBarItem({
    super.key,
    required this.icon,
    required this.text,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        final isSelected = state.selectedIndex == index;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.white : AppColors.secondaryText,
              size: 14,
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.secondaryText,
              ),
            ),
          ],
        );
      },
    );
  }
} 