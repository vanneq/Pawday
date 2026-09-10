import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/core/extension/entry_mood_extension.dart';
import 'package:kotik/core/model/diary/diary_model.dart';
import 'package:kotik/core/widgets/snackbar.dart';
import 'package:kotik/features/dairy/presentation/cubit/diary_cubit.dart';
import 'package:kotik/features/dairy/presentation/cubit/diary_state.dart';

class DiaryEntryDetailsPage extends StatelessWidget {
  final DiaryModel entry;

  const DiaryEntryDetailsPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DiaryCubit>(),
      child: _DiaryEntryDetailsView(entry: entry),
    );
  }
}

class _DiaryEntryDetailsView extends StatelessWidget {
  final DiaryModel entry;

  const _DiaryEntryDetailsView({required this.entry});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiaryCubit, DiaryState>(
      listener: (context, state) {
        if (state is DiaryEdited && context.canPop()) {
          showSuccessSnackbar(context, 'Запись успешно удалена');
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/diary_bg.png', fit: BoxFit.cover),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 12.h,
                      ),
                      child: IntrinsicHeight(
                        child: _EntryDetailsCard(entry: entry),
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

class _EntryDetailsCard extends StatelessWidget {
  final DiaryModel entry;

  const _EntryDetailsCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 12.h),
      decoration: BoxDecoration(
        color: colorScheme.onSecondary.withAlpha(235),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: colorScheme.outline.withAlpha(95)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(14),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _EntryDetailsHeader(),
          SizedBox(height: 8.h),
          _EntryDetailsImage(imageUrl: entry.imageUrl),
          SizedBox(height: 12.h),
          _EntryDetailsTitle(entry: entry),
          SizedBox(height: 8.h),
          _EntryDetailsMood(mood: entry.mood),
          SizedBox(height: 8.h),
          _EntryDetailsDate(date: entry.createdAt),
          const Spacer(),
          SizedBox(height: 16.h),
          _EntryDetailsActions(entry: entry),
        ],
      ),
    );
  }
}

class _EntryDetailsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.all(6.r),
            child: Icon(
              Icons.arrow_back_ios,
              size: 22.sp,
              color: colorScheme.onTertiary,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6.r),
          child: Icon(
            CupertinoIcons.ellipsis,
            size: 24.sp,
            color: colorScheme.onTertiary,
          ),
        ),
      ],
    );
  }
}

class _EntryDetailsImage extends StatelessWidget {
  final String? imageUrl;

  const _EntryDetailsImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (imageUrl == null || imageUrl!.isEmpty) {
      return AspectRatio(
        aspectRatio: 1.3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: ColoredBox(
            color: colorScheme.outline.withAlpha(40),
            child: const Center(
              child: _ImagePlaceholder(
                icon: CupertinoIcons.photo,
                text: 'Фото нет',
              ),
            ),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            return ColoredBox(
              color: colorScheme.outline.withAlpha(40),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
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
      ),
    );
  }
}

class _EntryDetailsTitle extends StatelessWidget {
  final DiaryModel entry;

  const _EntryDetailsTitle({required this.entry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            entry.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w900,
              height: 1.25,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(entry.mood.emoji, style: TextStyle(fontSize: 18.sp)),
      ],
    );
  }
}

class _EntryDetailsMood extends StatelessWidget {
  final CatMood mood;

  const _EntryDetailsMood({required this.mood});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(45),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        '${mood.emoji} ${mood.title}',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _EntryDetailsDate extends StatelessWidget {
  final DateTime date;

  const _EntryDetailsDate({required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatEntryDate(date),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _EntryDetailsActions extends StatelessWidget {
  final DiaryModel entry;
  const _EntryDetailsActions({required this.entry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: colorScheme.onSecondary.withAlpha(180),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colorScheme.outline.withAlpha(95)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            CupertinoIcons.share,
            color: colorScheme.onTertiary,
            size: 21.sp,
          ),
          GestureDetector(
            onTap: () => _showDeleteEntryDialog(context),
            behavior: HitTestBehavior.opaque,
            child: Icon(
              CupertinoIcons.delete,
              color: colorScheme.onTertiary,
              size: 21.sp,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteEntryDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _DeleteEntryDialog(
          onCancel: () => dialogContext.pop(),
          onDelete: () {
            dialogContext.pop();
            context.read<DiaryCubit>().deleteEntry(
              catId: entry.catId,
              entryId: entry.id,
            );
          },
        );
      },
    );
  }
}

class _DeleteEntryDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  const _DeleteEntryDialog({
    required this.onCancel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 16.h),
        decoration: BoxDecoration(
          color: colorScheme.onSecondary.withAlpha(245),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: colorScheme.outline.withAlpha(100)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(24),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DeleteEntryDialogIcon(),
            SizedBox(height: 12.h),
            Text(
              'Удалить запись?',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onTertiary,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Этот момент нельзя будет восстановить',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.secondary,
                height: 1.25,
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(
                  child: _DeleteEntryCancelButton(onPressed: onCancel),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _DeleteEntryConfirmButton(onPressed: onDelete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteEntryDialogIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: colorScheme.error.withAlpha(24),
        shape: BoxShape.circle,
      ),
      child: Icon(
        CupertinoIcons.trash,
        color: colorScheme.error,
        size: 24.sp,
      ),
    );
  }
}

class _DeleteEntryCancelButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DeleteEntryCancelButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 11.h),
        side: BorderSide(color: colorScheme.outline.withAlpha(130)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        'Отмена',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: colorScheme.onTertiary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _DeleteEntryConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DeleteEntryConfirmButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.error,
        foregroundColor: colorScheme.onError,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 11.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        'Удалить',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: colorScheme.onError,
          fontWeight: FontWeight.w900,
        ),
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
