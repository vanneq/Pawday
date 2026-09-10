import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/core/extension/entry_mood_extension.dart';
import 'package:kotik/core/model/diary/diary_model.dart';
import 'package:kotik/core/widgets/calendar.dart';
import 'package:kotik/core/widgets/primary_button.dart';
import 'package:kotik/core/widgets/snackbar.dart';
import 'package:kotik/features/dairy/presentation/cubit/diary_cubit.dart';
import 'package:kotik/features/dairy/presentation/cubit/diary_state.dart';

class EditEntryPage extends StatelessWidget {
  final DiaryModel entry;

  const EditEntryPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DiaryCubit>(),
      child: EditEntryView(entry: entry),
    );
  }
}

class EditEntryView extends StatefulWidget {
  final DiaryModel entry;

  const EditEntryView({super.key, required this.entry});

  @override
  State<EditEntryView> createState() => _EditEntryViewState();
}

class _EditEntryViewState extends State<EditEntryView> {
  late final TextEditingController controller;
  late DateTime _selectedDate;
  late CatMood _selectedMood;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.entry.description);
    _selectedDate = widget.entry.createdAt;
    _selectedMood = widget.entry.mood;
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiaryCubit, DiaryState>(
      listener: (context, state) {
        if (state is DiaryEdited) {
          showSuccessSnackbar(context, 'Запись успешно обновлена 🐾');
          context.go('/diary');
        }

        if (state is DiaryError) {
          showErrorSnackbar(context, state.error);
        }
      },
      child: BlocBuilder<DiaryCubit, DiaryState>(
        builder: (context, state) {
          final isLoading = state is DiaryEditing;

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
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
                            padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 0),
                            child: Column(
                              children: [
                                _Header(),
                                SizedBox(height: 20.h),
                                _LockedPhotoContainer(
                                  imageUrl: widget.entry.imageUrl,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Фото хранит момент таким, каким он был. Поэтому оставим его без изменений 🐾',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary.withAlpha(190),
                                        height: 1.25,
                                      ),
                                ),
                                SizedBox(height: 28.h),
                                _DescriptionContainer(controller: controller),
                                SizedBox(height: 28.h),
                                _Calendar(
                                  selectedDate: _selectedDate,
                                  onDateChanged: (date) {
                                    setState(() => _selectedDate = date);
                                  },
                                ),
                                SizedBox(height: 28.h),
                                _SelectMood(
                                  selectedMood: _selectedMood,
                                  onChanged: (mood) {
                                    setState(() => _selectedMood = mood);
                                  },
                                ),
                                SizedBox(height: 28.h),
                                PrimaryButton(
                                  text: 'Сохранить изменения',
                                  isLoading: isLoading,
                                  isActive: controller.text.trim().isNotEmpty,
                                  onPressed: () {
                                    if (controller.text.trim().isEmpty) {
                                      showErrorSnackbar(
                                        context,
                                        'Заполните описание',
                                      );
                                      return;
                                    }

                                    final updatedEntry = widget.entry.copyWith(
                                      createdAt: _selectedDate,
                                      description: controller.text.trim(),
                                      mood: _selectedMood,
                                    );

                                    context.read<DiaryCubit>().updateEntry(
                                      updatedEntry,
                                    );
                                  },
                                ),
                                SizedBox(height: 16.h),
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
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.pop(),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.arrow_back_ios, size: 26.sp),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'Редактировать запись',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: 8.h),
        Text(
          'Сохраните детали этого момента \n из жизни вашего котика',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.onTertiary.withAlpha(160),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _LockedPhotoContainer extends StatelessWidget {
  final String? imageUrl;

  const _LockedPhotoContainer({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(34.r),
        color: colorTheme.outline,
        strokeWidth: 2,
        dashPattern: const [6, 5],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30.h),
            decoration: BoxDecoration(
              color: colorTheme.outline.withAlpha(20),
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(color: Colors.white.withAlpha(100), width: 1),
            ),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),
                      child: SizedBox(
                        width: 118.w,
                        height: 96.h,
                        child: hasImage
                            ? Image.network(
                                imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const _PhotoPlaceholder();
                                },
                              )
                            : const _PhotoPlaceholder(),
                      ),
                    ),
                    Positioned(
                      right: -8.w,
                      bottom: -8.h,
                      child: _LockPhotoBadge(
                        backgroundColor: const Color.fromARGB(
                          255,
                          250,
                          233,
                          210,
                        ),
                        color: colorTheme.primary,
                        iconColor: colorTheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  hasImage ? 'Фото сохранено' : 'Фото не добавлено',
                  style: textTheme.bodyLarge!.copyWith(
                    color: colorTheme.onTertiary,
                  ),
                ),
                Text(
                  'Фото нельзя изменить',
                  style: textTheme.bodyLarge!.copyWith(
                    color: colorTheme.secondary,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.outline.withAlpha(40),
      child: Center(
        child: Icon(
          CupertinoIcons.photo,
          color: Theme.of(context).colorScheme.secondary,
          size: 28.sp,
        ),
      ),
    );
  }
}

class _LockPhotoBadge extends StatelessWidget {
  final Color backgroundColor;
  final Color color;
  final Color iconColor;

  const _LockPhotoBadge({
    required this.backgroundColor,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor,
      ),
      padding: EdgeInsets.all(5.r),
      child: Container(
        padding: EdgeInsets.all(2.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
        ),
        child: Icon(CupertinoIcons.lock_fill, color: iconColor),
      ),
    );
  }
}

class _DescriptionContainer extends StatelessWidget {
  final TextEditingController controller;

  const _DescriptionContainer({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      height: 92.h,
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 6.h),
      decoration: BoxDecoration(
        color: colorTheme.onSecondary,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colorTheme.outline.withAlpha(120)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Описание',
            style: textTheme.bodyMedium?.copyWith(
              color: colorTheme.onTertiary.withAlpha(180),
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              maxLength: 500,
              minLines: null,
              maxLines: null,
              expands: true,
              style: textTheme.bodyMedium?.copyWith(
                color: colorTheme.onSurface,
              ),
              decoration: InputDecoration(
                filled: false,
                hintText: 'Что сегодня произошло?',
                hintStyle: textTheme.bodyMedium?.copyWith(
                  color: colorTheme.secondary.withAlpha(150),
                ),
                counterStyle: textTheme.bodySmall?.copyWith(
                  color: colorTheme.secondary.withAlpha(170),
                  fontSize: 11.sp,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 4.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Calendar extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const _Calendar({required this.selectedDate, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Выберите дату',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 4.h),
        CalendarSection(
          initialSelected: selectedDate,
          onDateChanged: onDateChanged,
          builder: (context, selectedDate) => Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectMood extends StatelessWidget {
  final CatMood selectedMood;
  final ValueChanged<CatMood> onChanged;

  const _SelectMood({required this.selectedMood, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выберите настроение',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: CatMood.values.map((mood) {
              return GestureDetector(
                onTap: () => onChanged(mood),
                child: _MoodItem(isSelected: selectedMood == mood, mood: mood),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _MoodItem extends StatelessWidget {
  final CatMood mood;
  final bool isSelected;

  const _MoodItem({required this.mood, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: isSelected
          ? EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h)
          : EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primary
            : colorScheme.onSecondary.withAlpha(100),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.white.withAlpha(110),
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(mood.emoji, style: TextStyle(fontSize: 16.sp)),
          SizedBox(width: 6.w),
          Text(
            mood.title,
            style: isSelected
                ? textTheme.labelLarge?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  )
                : textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onTertiary,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ],
      ),
    );

    if (isSelected) return content;

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(12.r),
        color: colorScheme.outline,
        dashPattern: const [5, 4],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: content,
        ),
      ),
    );
  }
}
