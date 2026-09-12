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
    final screenWidth = MediaQuery.of(context).size.width;
    final metrics = _CatSelectorMetrics.fromWidth(screenWidth);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: metrics.rowMinHeight,
            maxHeight: metrics.rowMaxHeight,
          ),
          child: SizedBox(
            height: metrics.rowHeight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...cats.map(
                    (c) => Padding(
                      padding: EdgeInsets.only(right: 6.w),
                      child: CatSelectorCard(
                        cat: c,
                        isSelect: selectedCatId == c.id,
                        metrics: metrics,
                        onTap: () => onCatTap(c),
                      ),
                    ),
                  ),
                  AddCatCard(metrics: metrics, onTap: onAddCatTap),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CatSelectorCard extends StatelessWidget {
  final CatModel cat;
  final bool isSelect;
  final _CatSelectorMetrics metrics;

  final VoidCallback? onTap;

  const CatSelectorCard({
    super.key,
    required this.cat,
    required this.isSelect,
    required this.metrics,
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
        padding: EdgeInsets.symmetric(
          horizontal: metrics.cardHorizontalPadding,
          vertical: metrics.cardVerticalPadding,
        ),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withAlpha(160),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelect ? colorScheme.primary : colorScheme.outline,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CatAvatar(
              width: metrics.avatarSize,
              height: metrics.avatarSize,
              asset: cat.color.imagePath,
            ),
            SizedBox(height: metrics.contentGap),
            Text(
              cat.name,
              style: textTheme.bodyLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class AddCatCard extends StatelessWidget {
  final _CatSelectorMetrics metrics;
  final VoidCallback onTap;

  const AddCatCard({super.key, required this.metrics, required this.onTap});

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
          padding: EdgeInsets.symmetric(
            horizontal: metrics.addCardHorizontalPadding,
            vertical: metrics.cardVerticalPadding,
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: metrics.addButtonSize,
                height: metrics.addButtonSize,
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
                  size: metrics.addIconSize,
                ),
              ),
              SizedBox(height: metrics.contentGap),
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

class _CatSelectorMetrics {
  final double rowMinHeight;
  final double rowMaxHeight;
  final double rowHeight;
  final double avatarSize;
  final double addButtonSize;
  final double addIconSize;
  final double cardHorizontalPadding;
  final double addCardHorizontalPadding;
  final double cardVerticalPadding;
  final double contentGap;

  const _CatSelectorMetrics({
    required this.rowMinHeight,
    required this.rowMaxHeight,
    required this.rowHeight,
    required this.avatarSize,
    required this.addButtonSize,
    required this.addIconSize,
    required this.cardHorizontalPadding,
    required this.addCardHorizontalPadding,
    required this.cardVerticalPadding,
    required this.contentGap,
  });

  factory _CatSelectorMetrics.fromWidth(double width) {
    final isSmall = width < 380;
    final avatarSize = isSmall ? 96.w : 90.w;
    final cardVerticalPadding = isSmall ? 12.h : 8.h;
    final contentGap = 6.h;
    final rowMinHeight = isSmall ? 168.h : 150.h;
    final rowMaxHeight = isSmall ? 235.h : 195.h;

    return _CatSelectorMetrics(
      rowMinHeight: rowMinHeight,
      rowMaxHeight: rowMaxHeight,
      rowHeight: rowMaxHeight,
      avatarSize: avatarSize,
      addButtonSize: isSmall ? 58.r : 54.r,
      addIconSize: isSmall ? 34.r : 32.r,
      cardHorizontalPadding: 12.w,
      addCardHorizontalPadding: 22.w,
      cardVerticalPadding: cardVerticalPadding,
      contentGap: contentGap,
    );
  }
}
