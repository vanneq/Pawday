import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kotik/core/model/food/food_model.dart';

class FoodSelector extends StatelessWidget {
  final List<FoodModel> foods;
  final FoodModel? selectedFood;
  final ValueChanged<FoodModel> onFoodSelected;
  final Map<FoodType, int> inventory;

  const FoodSelector({
    super.key,
    required this.foods,
    required this.selectedFood,
    required this.onFoodSelected,
    required this.inventory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: foods.map((food) {
            final isSelected = selectedFood == food;
            return Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: _FoodSelectorCard(
                inventory: inventory,
                food: food,
                isSelected: isSelected,
                onTap: () => onFoodSelected(food),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _FoodSelectorCard extends StatelessWidget {
  final FoodModel food;
  final bool isSelected;
  final VoidCallback onTap;
  final Map<FoodType, int> inventory;

  const _FoodSelectorCard({
    required this.food,
    required this.isSelected,
    required this.onTap,
    required this.inventory,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final quantity = inventory[food.type] ?? 0;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 130.w,
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: colorScheme.onPrimary,
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: colorScheme.primary.withAlpha(50),
                ),
                child: Text(
                  quantity.toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Image.asset(food.imagePath, width: 100.w, height: 100.h),
            SizedBox(height: 8.h),
            Text(
              food.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
