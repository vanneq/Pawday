import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/extension/cat_extension.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/core/model/food/food_model.dart';
import 'package:kotik/core/widgets/primary_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:kotik/features/main/presentation/widgets/food_selector.dart';

class HungryPage extends StatelessWidget {
  final CatModel selectCat;

  const HungryPage({super.key, required this.selectCat});

  @override
  Widget build(BuildContext context) {
    return HungryView(selectCat: selectCat);
  }
}

class HungryView extends StatefulWidget {
  final CatModel selectCat;

  const HungryView({super.key, required this.selectCat});

  @override
  State<HungryView> createState() => _HungryViewState();
}

class _HungryViewState extends State<HungryView> {
  FoodModel? _selectedFood;

  void _onFoodSelected(FoodModel food) {
    setState(() => _selectedFood = food);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/diary_bg.png', fit: BoxFit.fill),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                child: Icon(Icons.arrow_back_ios_new),
                                onTap: () => context.pop(),
                              ),
                              SizedBox(width: 18.w),
                              Text(
                                'Голод',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          _HungryProfileRow(selectCat: widget.selectCat),
                          SizedBox(height: 14.h),
                          _NewEntryFoodCard(catName: widget.selectCat.name),
                          SizedBox(height: 20.h),
                          _MyFoodList(
                            catId: widget.selectCat.id,
                            selectedFood: _selectedFood,
                            onFoodSelected: _onFoodSelected,
                          ),
                          SizedBox(height: 14.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MyFoodList extends StatelessWidget {
  final String catId;
  final FoodModel? selectedFood;
  final ValueChanged<FoodModel> onFoodSelected;

  const _MyFoodList({
    required this.catId,
    required this.selectedFood,
    required this.onFoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Моя еда',
            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight(800)),
          ),
        ),
        SizedBox(height: 10.h),
        FoodSelector(
          foods: foods,
          selectedFood: selectedFood,
          onFoodSelected: onFoodSelected,
        ),
        SizedBox(height: 10.h),
        PrimaryButton(text: 'Покормить', onPressed: () {}),
        SizedBox(height: 6.h),
        if (selectedFood != null)
          Text(
            '1 ${selectedFood!.name} = +${selectedFood!.satietyPercent}% сытости',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
            ),
          ),
        SizedBox(height: 14.h),
        _CreateEntryCard(catId: catId),
        SizedBox(height: 8.h),
        const _FoodDropInfoCard(),
      ],
    );
  }
}

class _NewEntryFoodCard extends StatelessWidget {
  final String catName;
  const _NewEntryFoodCard({required this.catName});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withAlpha(210),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: colorScheme.outline.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(28),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.camera_alt_rounded,
              color: colorScheme.primary,
              size: 30.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'За каждую новую запись +3 еды',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Фотографируйте и записывайте приключения $catName, чтобы получать еду для него!',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: colorScheme.onSurface.withAlpha(150),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodDropInfoCard extends StatelessWidget {
  const _FoodDropInfoCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withAlpha(170),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colorScheme.outline.withAlpha(100)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.priority_high_sharp,
              color: colorScheme.primary,
              size: 22.sp,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                'За новую запись котик получит еду, а какую именно — решит случай. У каждого угощения свой шанс выпасть 🐾',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withAlpha(170),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HungryProfileRow extends StatelessWidget {
  final CatModel selectCat;
  const _HungryProfileRow({required this.selectCat});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 380;
    final profileAvatarSize = isSmallScreen ? 110.w : 100.w;
    final profileCatScale = isSmallScreen ? 1.04 : 1.0;
    final profileCatOffset = isSmallScreen
        ? Offset(4.w, 13.h)
        : Offset(4.w, 14.h);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withAlpha(160),
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        children: [
          _ProfileCatAvatar(
            size: profileAvatarSize,
            asset: selectCat.color.imagePath,
            imageScale: profileCatScale,
            imageOffset: profileCatOffset,
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Сытость: ',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(150),
                      ),
                    ),
                    Text(
                      '${selectCat.hungry.clamp(0, 100)}%',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(190),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                LinearProgressIndicator(
                  value: selectCat.hungry.clamp(0, 100) / 100,
                  minHeight: 10.h,
                  borderRadius: BorderRadius.circular(8.r),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.outline.withAlpha(150),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCatAvatar extends StatelessWidget {
  final double size;
  final String asset;
  final double imageScale;
  final Offset imageOffset;

  const _ProfileCatAvatar({
    required this.size,
    required this.asset,
    required this.imageScale,
    required this.imageOffset,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outline.withAlpha(150)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Transform.translate(
        offset: imageOffset,
        child: Transform.scale(
          scale: imageScale,
          child: Image.asset(asset, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _CreateEntryCard extends StatelessWidget {
  final String catId;

  const _CreateEntryCard({required this.catId});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(16.r),
        color: colorScheme.primary.withAlpha(110),
        strokeWidth: 1.5,
        dashPattern: const [5, 4],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => context.push('/diary/add_entry', extra: catId),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withAlpha(170),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withAlpha(28),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: colorScheme.primary,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Новая запись',
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Получить +3 еды за новую запись',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          color: colorScheme.onSurface.withAlpha(150),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: colorScheme.onSurface),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
