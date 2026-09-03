import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatAvatar extends StatelessWidget {
  final double? width;
  final double? height;
  final String asset;

  const CatAvatar({
    super.key,
    this.width,
    this.height,
    this.asset = 'assets/cats/empty_cat.png',
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
          color: Theme.of(context).colorScheme.outline.withAlpha(150),
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
