import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kotik/core/model/food/food_model.dart';

class FoodRewardDialog extends StatelessWidget {
  final List<FoodType> gettingFood;

  const FoodRewardDialog({super.key, required this.gettingFood});

  String _foodName(FoodType type) {
    return switch (type) {
      FoodType.fish => 'Рыба',
      FoodType.feed => 'Корм',
      FoodType.treats => 'Лакомство',
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5E5),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: colorScheme.outline.withAlpha(90)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(35),
              blurRadius: 24.r,
              offset: Offset(0, 12.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, color: colorScheme.onSurface),
              ),
            ),

            Text(
              'Награда за запись!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Твой котик очень доволен!\nВот что тебе выпало:',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withAlpha(165),
                height: 1.35,
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var index = 0; index < gettingFood.length; index++) ...[
                  if (index > 0) SizedBox(width: 8.w),
                  Flexible(
                    child: _FoodRewardTile(
                      type: gettingFood[index],
                      name: _foodName(gettingFood[index]),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                child: Text(
                  'Отлично!',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodRewardTile extends StatelessWidget {
  final FoodType type;
  final String name;

  const _FoodRewardTile({required this.type, required this.name});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final food = foods.firstWhere((food) => food.type == type);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 82.w,
          height: 82.w,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF4E7D2),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Image.asset(food.imagePath, fit: BoxFit.contain),
        ),
        SizedBox(height: 6.h),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
