import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                  Text('О приложении', style: textTheme.headlineLarge),
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
                        Icons.pets_rounded,
                        color: colorScheme.primary,
                        size: 40.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'PawDay',
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Дневник тёплых моментов с вашим котиком',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
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
                      'Сохраняйте ваши истории',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Добавляйте фотографии и заметки, следите за сытостью котика и собирайте для него угощения за новые записи.',
                      style: textTheme.bodyMedium?.copyWith(
                        height: 1.4,
                        color: colorScheme.onSurface.withAlpha(180),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _FaqSection(colorScheme: colorScheme, textTheme: textTheme),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withAlpha(150),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: colorScheme.outline.withAlpha(130)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: colorScheme.primary,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Версия приложения: 1.0.0',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
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

class _FaqSection extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _FaqSection({required this.colorScheme, required this.textTheme});

  static const _questions = [
    (
      question: 'Как добавить запись в дневник?',
      answer:
          'Нажмите «Новая запись», выберите фотографию и сохраните запись. '
          'За запись с фото котик получит угощения.',
    ),
    (
      question: 'Как получить еду для котика?',
      answer:
          'За новую запись с фотографией котик получает 3 угощения. Какие именно '
          'угощения выпадут, определяется случайно.',
    ),
    (
      question: 'Почему сытость уменьшается?',
      answer:
          'Сытость котика уменьшается на 5% каждый час. Выберите угощение '
          'в разделе «Голод» и нажмите «Покормить», чтобы восстановить её.',
    ),
    (
      question: 'Можно добавить несколько котиков?',
      answer:
          'Да. Добавьте котиков в профиле и переключайтесь между ними, '
          'чтобы вести для каждого свою историю.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withAlpha(150),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline.withAlpha(130)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 4.h),
              child: Text(
                'Частые вопросы',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            for (var index = 0; index < _questions.length; index++) ...[
              if (index > 0)
                Divider(
                  height: 1,
                  indent: 16.w,
                  endIndent: 16.w,
                  color: colorScheme.outline.withAlpha(110),
                ),
              ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
                iconColor: colorScheme.primary,
                collapsedIconColor: colorScheme.primary,
                title: Text(
                  _questions[index].question,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _questions[index].answer,
                      style: textTheme.bodyMedium?.copyWith(
                        height: 1.4,
                        color: colorScheme.onSurface.withAlpha(175),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
