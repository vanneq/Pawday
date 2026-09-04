import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kotik/core/extension/cat_extension.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/features/profile/presentation/widgets/cat_avatar.dart';

class CatSelector extends StatelessWidget {
  final List<CatModel> cats;
  final String? selectedCatId;
  final void Function(CatModel cat) onCatTap;
  final VoidCallback onAddCatTap;
  final bool showLabel;

  const CatSelector({
    super.key,

    this.showLabel = false,
    required this.cats,
    this.selectedCatId,
    required this.onCatTap,
    required this.onAddCatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            children: [
              ...cats.map(
                (c) => Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: CatSelectorCard(
                    cat: c,
                    isSelect: selectedCatId == c.id,
                    onTap: () => onCatTap(c),
                  ),
                ),
              ),
              AddCatCard(onTap: onAddCatTap),
            ],
          ),
        ),
      ],
    );
  }
}

class CatSelectorCard extends StatelessWidget {
  final CatModel cat;
  final bool isSelect;

  final VoidCallback? onTap;

  const CatSelectorCard({
    super.key,
    required this.cat,
    required this.isSelect,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 120.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withAlpha(160),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelect ? colorScheme.primary : colorScheme.outline,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            CatAvatar(width: 90.w, height: 90.w, asset: cat.color.imagePath),
            SizedBox(height: 6.h),
            Text(cat.name, style: textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class AddCatCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddCatCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(16.r),
          color: Theme.of(context).colorScheme.outline,
          strokeWidth: 2.5,
          dashPattern: const [5, 4],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 54.r,
                height: 54.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onTertiary.withAlpha(170),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.add,
                  color: Theme.of(
                    context,
                  ).colorScheme.onTertiary.withAlpha(170),
                  size: 32.r,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Добавить\nкотика',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
