import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/core/extension/entry_mood_extension.dart';
import 'package:kotik/core/model/diary/diary_model.dart';
import 'package:kotik/features/dairy/presentation/cubit/diary_cubit.dart';
import 'package:kotik/features/dairy/presentation/cubit/diary_state.dart';
import 'package:kotik/features/main/presentation/cubit/cats_cubit.dart';
import 'package:kotik/features/main/presentation/cubit/cats_state.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DiaryCubit>(),
      child: const DiaryView(),
    );
  }
}

class DiaryView extends StatefulWidget {
  const DiaryView({super.key});

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  CatMood? selectedMood;
  String? _watchedCatId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                      child: Column(
                        children: [
                          _Header(),
                          SizedBox(height: 18.h),
                          _MoodRow(
                            selectedMood: selectedMood,
                            onChanged: (mood) {
                              setState(() {
                                selectedMood = mood;
                              });
                            },
                          ),
                          SizedBox(height: 12.h),
                          BlocBuilder<CatsCubit, CatsState>(
                            builder: (context, catsState) {
                              if (catsState is! CatsLoadedData ||
                                  catsState.selectedCat == null) {
                                return const _EmptyDiaryText(
                                  text:
                                      'Выберите котика, чтобы увидеть записи',
                                );
                              }

                              _watchEntries(catsState.selectedCat!.id);

                              return BlocBuilder<DiaryCubit, DiaryState>(
                                builder: (context, diaryState) {
                                  if (diaryState is DiaryLoading) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 24.h),
                                      child: const CircularProgressIndicator(),
                                    );
                                  }

                                  if (diaryState is DiaryError) {
                                    return _EmptyDiaryText(
                                      text: diaryState.error,
                                    );
                                  }

                                  if (diaryState is DiaryLoadedData) {
                                    final entries = selectedMood == null
                                        ? [...diaryState.diaryEntries]
                                        : diaryState.diaryEntries
                                              .where(
                                                (entry) =>
                                                    entry.mood == selectedMood,
                                              )
                                              .toList();

                                    entries.sort(
                                      (a, b) =>
                                          b.createdAt.compareTo(a.createdAt),
                                    );

                                    if (entries.isEmpty) {
                                      return const _EmptyDiaryText(
                                        text: 'Записей пока нет',
                                      );
                                    }

                                    return _EntryList(entries: entries);
                                  }

                                  return const SizedBox.shrink();
                                },
                              );
                            },
                          ),
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

  void _watchEntries(String catId) {
    if (_watchedCatId == catId) return;

    _watchedCatId = catId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<DiaryCubit>().watchEntries(catId);
    });
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Дневник', style: Theme.of(context).textTheme.headlineLarge),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: InkWell(
            child: Icon(
              Icons.tune,
              size: 30,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _MoodRow extends StatelessWidget {
  final CatMood? selectedMood;
  final ValueChanged<CatMood?> onChanged;

  const _MoodRow({required this.selectedMood, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () => onChanged(null),
            child: Row(
              children: [
                _MoodItem(isSelected: selectedMood == null, title: 'Все'),
                SizedBox(width: 6.w),
              ],
            ),
          ),
          ...CatMood.values.map((mood) {
            return GestureDetector(
              onTap: () => onChanged(mood),
              child: Row(
                children: [
                  _MoodItem(
                    isSelected: selectedMood == mood,
                    title: mood.title,
                    emoji: mood.emoji,
                  ),
                  SizedBox(width: 6.w),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _MoodItem extends StatelessWidget {
  final String title;
  final String? emoji;
  final bool isSelected;

  const _MoodItem({required this.title, required this.isSelected, this.emoji});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primary
            : colorScheme.outline.withAlpha(60),
        border: Border.all(
          color: isSelected ? Colors.transparent : colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (emoji != null) ...[Text(emoji!), SizedBox(width: 4.w)],
          Text(
            title,
            style: isSelected
                ? Theme.of(context).textTheme.labelLarge
                : Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _EntryList extends StatelessWidget {
  final List<DiaryModel> entries;

  const _EntryList({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final entry in entries) ...[
          _EntryCard(
            entry: entry,
            onTap: () => context.push('/diary/entry', extra: entry),
          ),
          SizedBox(height: 10.h),
        ],
      ],
    );
  }
}

class _EntryCard extends StatelessWidget {
  final DiaryModel entry;
  final VoidCallback onTap;

  const _EntryCard({required this.entry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: colorScheme.onSecondary.withAlpha(230),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: colorScheme.outline.withAlpha(95)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _EntryImage(imageUrl: entry.imageUrl),
            SizedBox(width: 10.w),
            Expanded(
              child: SizedBox(
                height: 76.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            entry.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w800,
                              height: 1.25,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          entry.mood.emoji,
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      _formatEntryDate(entry.createdAt),
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.secondary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EntryImage extends StatelessWidget {
  final String? imageUrl;

  const _EntryImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (imageUrl == null || imageUrl!.isEmpty) {
      return const _ImagePlaceholder(
        icon: CupertinoIcons.photo,
        text: 'Фото нет',
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(9.r),
      child: Image.network(
        imageUrl!,
        width: 86.w,
        height: 76.h,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Container(
            width: 86.w,
            height: 76.h,
            color: colorScheme.outline.withAlpha(40),
            child: Center(
              child: SizedBox(
                width: 18.r,
                height: 18.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const _ImagePlaceholder(
            icon: CupertinoIcons.exclamationmark_triangle,
            text: 'Ошибка',
          );
        },
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ImagePlaceholder({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 86.w,
      height: 76.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.r),
        color: colorScheme.outline.withAlpha(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: colorScheme.secondary, size: 22.sp),
          SizedBox(height: 4.h),
          Text(
            text,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.secondary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyDiaryText extends StatelessWidget {
  final String text;

  const _EmptyDiaryText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

String _formatEntryDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = _monthName(date.month);
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');

  return '$day $month ${date.year}, $hour:$minute';
}

String _monthName(int month) {
  const months = [
    'янв',
    'фев',
    'мар',
    'апр',
    'мая',
    'июн',
    'июл',
    'авг',
    'сен',
    'окт',
    'ноя',
    'дек',
  ];

  return months[month - 1];
}

