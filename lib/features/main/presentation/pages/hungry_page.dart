import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/core/extension/cat_extension.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/features/main/domain/utils/satiety_calculator.dart';
import 'package:kotik/core/model/food/food_model.dart';
import 'package:kotik/core/widgets/primary_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:kotik/core/widgets/snackbar.dart';
import 'package:kotik/features/main/presentation/cubit/cats_cubit.dart';
import 'package:kotik/features/main/presentation/cubit/cats_state.dart';
import 'package:kotik/features/main/presentation/cubit/food_cubit.dart';
import 'package:kotik/features/main/presentation/cubit/food_state.dart';
import 'package:kotik/features/main/presentation/widgets/food_selector.dart';

class HungryPage extends StatelessWidget {
  final CatModel selectCat;

  const HungryPage({super.key, required this.selectCat});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final cubit = getIt<FoodCubit>();
            cubit.watchInventory();
            return cubit;
          },
        ),
      ],
      child: HungryView(selectCat: selectCat),
    );
  }
}

class HungryView extends StatefulWidget {
  final CatModel selectCat;

  const HungryView({super.key, required this.selectCat});

  @override
  State<HungryView> createState() => _HungryViewState();
}

class _HungryViewState extends State<HungryView> with WidgetsBindingObserver {
  FoodModel? _selectedFood;
  Timer? _satietyTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _satietyTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _satietyTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onFoodSelected(FoodModel food) {
    setState(() => _selectedFood = food);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FoodCubit, FoodState>(
      listener: (BuildContext context, state) {
        if (state is FoodLoading) {
          CircularProgressIndicator();
        }
        if (state is FoodError) {
          showErrorSnackbar(context, state.error);
        }
      },
      child: Scaffold(
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
                        child: BlocBuilder<FoodCubit, FoodState>(
                          builder: (BuildContext context, state) {
                            return Column(
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
                                BlocBuilder<CatsCubit, CatsState>(
                                  builder: (context, state) {
                                    final cat = state is CatsLoadedData
                                        ? state.cats.firstWhere(
                                            (cat) =>
                                                cat.id == widget.selectCat.id,
                                            orElse: () => widget.selectCat,
                                          )
                                        : widget.selectCat;

                                    return _HungryProfileRow(selectCat: cat);
                                  },
                                ),
                                SizedBox(height: 8.h),
                                const _SatietyDecayNote(),
                                SizedBox(height: 14.h),
                                _NewEntryFoodCard(
                                  catName: widget.selectCat.name,
                                ),
                                SizedBox(height: 20.h),
                                if (state is FoodsLoadedData)
                                  _MyFoodList(
                                    inventory: state.inventory,
                                    isOperationProgress:
                                        state.isOperationProgress,
                                    catId: widget.selectCat.id,
                                    selectedFood: _selectedFood,
                                    onFoodSelected: _onFoodSelected,
                                  ),
                                SizedBox(height: 14.h),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyFoodList extends StatelessWidget {
  final String catId;
  final FoodModel? selectedFood;
  final ValueChanged<FoodModel> onFoodSelected;
  final Map<FoodType, int> inventory;
  final bool isOperationProgress;

  const _MyFoodList({
    required this.catId,
    required this.selectedFood,
    required this.onFoodSelected,
    required this.inventory,
    required this.isOperationProgress,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final selectedFoodQuantity = selectedFood == null
        ? 0
        : inventory[selectedFood!.type] ?? 0;

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
          inventory: inventory,
          foods: foods,
          selectedFood: selectedFood,
          onFoodSelected: onFoodSelected,
        ),
        SizedBox(height: 10.h),
        PrimaryButton(
          text: 'Покормить',
          isLoading: isOperationProgress,
          onPressed: () async {
            final food = selectedFood;
            if (food == null) return;

            final wasFed = await context.read<FoodCubit>().feedCat(
              catId,
              food.type,
            );
            if (!context.mounted || !wasFed) return;

            await showGeneralDialog<void>(
              context: context,
              barrierDismissible: true,
              barrierLabel: 'Котик поел',
              barrierColor: Colors.black.withAlpha(100),
              transitionDuration: const Duration(milliseconds: 450),
              pageBuilder: (context, animation, secondaryAnimation) {
                return _FeedSuccessDialog(food: food);
              },
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.elasticOut,
                    );
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: curvedAnimation,
                        child: child,
                      ),
                    );
                  },
            );
          },
          isActive: selectedFoodQuantity > 0,
        ),
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

class _FeedSuccessDialog extends StatelessWidget {
  final FoodModel food;

  const _FeedSuccessDialog({required this.food});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 36.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 22.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5E5),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: colorScheme.outline.withAlpha(90)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.auto_awesome,
                  size: 100.sp,
                  color: colorScheme.primary.withAlpha(35),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: -0.12, end: 0),
                  duration: const Duration(milliseconds: 650),
                  curve: Curves.elasticOut,
                  builder: (context, angle, child) =>
                      Transform.rotate(angle: angle, child: child),
                  child: Image.asset(
                    food.imagePath,
                    width: 94.w,
                    height: 94.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Ням!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Котику понравилось угощение',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withAlpha(170),
              ),
            ),
            SizedBox(height: 18.h),
            SizedBox(
              width: double.infinity,
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
                child: const Text('Ура!'),
              ),
            ),
          ],
        ),
      ),
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
                  'Фотографируйте и записывайте приключения $catName, чтобы получать еду!',
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
    final satiety = calculateSatiety(
      hungry: selectCat.hungry,
      updatedAt: selectCat.satietyUpdatedAt,
    );
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
                      '$satiety%',
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
                  value: satiety / 100,
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

class _SatietyDecayNote extends StatelessWidget {
  const _SatietyDecayNote();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withAlpha(170),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.outline.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(28),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.schedule_rounded,
              color: colorScheme.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Сытость убывает на 5% каждый час. Не забывайте кормить котика — что будет при 0%, лучше не проверять 🙀',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withAlpha(180),
              ),
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
