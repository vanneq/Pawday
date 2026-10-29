import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(CupertinoIcons.back),
                    tooltip: 'Назад',
                  ),
                  SizedBox(width: 4.w),
                  Text('Поддержка', style: textTheme.headlineLarge),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withAlpha(170),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: colorScheme.outline.withAlpha(150)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 76.w,
                      height: 76.w,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withAlpha(25),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.support_agent_rounded,
                        color: colorScheme.primary,
                        size: 40.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Мы рядом',
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Возник вопрос или что-то не получилось? Напишите нам — постараемся помочь.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        height: 1.4,
                        color: colorScheme.onSurface.withAlpha(170),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withAlpha(150),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: colorScheme.outline.withAlpha(130)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Как мы можем помочь?',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Опишите проблему или задайте вопрос. Если речь об ошибке, расскажите, что вы делали перед её появлением.',
                      style: textTheme.bodyMedium?.copyWith(
                        height: 1.4,
                        color: colorScheme.onSurface.withAlpha(180),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withAlpha(150),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: colorScheme.outline.withAlpha(130)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: colorScheme.primary,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Почта для связи',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withAlpha(130),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: colorScheme.outline.withAlpha(130),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
