import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatAvatar extends StatelessWidget {
  final double? width;
  final double? height;
  final String asset;
  final bool withAlpha;
  final double widthBorder;
  final bool isSelected;

  const CatAvatar({
    super.key,
    this.width,
    this.height,
    this.asset = 'assets/cats/empty_cat.png',
    this.withAlpha = true,
    this.widthBorder = 1,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 84.w,
      height: height ?? 84.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: withAlpha
              ? Theme.of(context).colorScheme.outline.withAlpha(150)
              : isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline,
          width: widthBorder,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Transform.translate(
        offset: Offset(4.w, 14.h),
        child: Image.asset(asset, fit: BoxFit.cover),
      ),
    );
  }
}
