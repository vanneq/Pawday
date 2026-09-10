import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/core/extension/entry_mood_extension.dart';
import 'package:kotik/core/model/diary/diary_model.dart';
import 'package:kotik/core/widgets/calendar.dart';
import 'package:kotik/core/widgets/primary_button.dart';
import 'package:kotik/core/widgets/snackbar.dart';
import 'package:kotik/features/dairy/presentation/cubit/diary_cubit.dart';
import 'package:kotik/features/dairy/presentation/cubit/diary_state.dart';

class AddEntryPage extends StatelessWidget {
  final String catId;
  const AddEntryPage({super.key, required this.catId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DiaryCubit>(),
      child: AddEntryView(catId: catId),
    );
  }
}

class AddEntryView extends StatefulWidget {
  final String catId;
  const AddEntryView({super.key, required this.catId});

  @override
  State<AddEntryView> createState() => _AddEntryViewState();
}

class _AddEntryViewState extends State<AddEntryView> {
  final TextEditingController controller = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImageFile;
  DateTime _selectedDate = DateTime.now();
  CatMood _selectedMood = CatMood.funny;

  @override
  void initState() {
    super.initState();
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
        if (state is DiaryAdded) {
          showSuccessSnackbar(context, 'Запись успешно добавлена 🐾');

          context.go('/main');
        }

        if (state is DiaryError) {
          showErrorSnackbar(context, state.error);
        }
      },
      child: Scaffold(
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
                            _UploadPhotoContainer(
                              imageFile: _selectedImageFile,
                              onTap: _showPhotoSourcePicker,
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
                              text: 'Создать запись',
                              isActive: controller.text.trim().isNotEmpty,
                              onPressed: () async {
                                if (controller.text.trim().isEmpty) {
                                  showErrorSnackbar(
                                    context,
                                    'Заполните описание',
                                  );
                                  return;
                                }

                                final newDiary = DiaryParams(
                                  catId: widget.catId,
                                  createdAt: _selectedDate,
                                  description: controller.text.trim(),
                                  mood: _selectedMood,
                                  imageFile: _selectedImageFile,
                                );
                                context.read<DiaryCubit>().addEntry(newDiary);
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
      ),
    );
  }

  Future<void> _pickImage() async {
    await _pickImageFromSource(ImageSource.gallery);
  }

  Future<void> _takePhoto() async {
    await _pickImageFromSource(ImageSource.camera);
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      final pickedImage = await _imagePicker.pickImage(
        source: source,
        imageQuality: 100,
      );

      if (pickedImage == null || !mounted) return;

      setState(() {
        _selectedImageFile = File(pickedImage.path);
      });
    } catch (error, stackTrace) {
      debugPrint('Pick image error: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (!mounted) return;
      showErrorSnackbar(context, 'Не удалось выбрать фото');
    }
  }

  void _showPhotoSourcePicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _PhotoSourceSheet(
          onCameraTap: () {
            context.pop();
            _takePhoto();
          },
          onGalleryTap: () {
            context.pop();
            _pickImage();
          },
        );
      },
    );
  }
}

class _PhotoSourceSheet extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const _PhotoSourceSheet({
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorTheme.surface,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: colorTheme.outline.withAlpha(90)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(28),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PhotoSourceTile(
                  icon: CupertinoIcons.camera,
                  title: 'Сделать фото',
                  onTap: onCameraTap,
                ),
                _PhotoSourceTile(
                  icon: CupertinoIcons.photo,
                  title: 'Выбрать из галереи',
                  onTap: onGalleryTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoSourceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _PhotoSourceTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 42.w,
        height: 42.w,
        decoration: BoxDecoration(
          color: colorTheme.primary.withAlpha(28),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: colorTheme.primary, size: 24.sp),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: colorTheme.onTertiary,
          fontWeight: FontWeight.w700,
        ),
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
            onTap: () => context.go('/main'),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.arrow_back_ios, size: 26),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text('Новая запись', style: Theme.of(context).textTheme.headlineLarge),
        SizedBox(height: 8.h),
        Text(
          'Сохраните особенный момент \n из жизни вашего котика',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onTertiary.withAlpha(160),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _UploadPhotoContainer extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;

  const _UploadPhotoContainer({required this.imageFile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bgAddImageButton = Color.fromARGB(255, 250, 233, 210);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DottedBorder(
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
                border: Border.all(
                  color: Colors.white.withAlpha(100),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  if (imageFile != null)
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18.r),
                          child: Image.file(
                            imageFile!,
                            width: 118.w,
                            height: 96.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: -8.w,
                          bottom: -8.h,
                          child: _AddPhotoBadge(
                            backgroundColor: bgAddImageButton,
                            iconColor: colorTheme.onPrimary,
                            color: colorTheme.primary,
                            icon: CupertinoIcons.pencil,
                          ),
                        ),
                      ],
                    )
                  else
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          CupertinoIcons.photo,
                          color: colorTheme.secondary,
                          size: 70,
                        ),
                        Positioned(
                          right: -12.w,
                          bottom: -6.h,
                          child: _AddPhotoBadge(
                            backgroundColor: bgAddImageButton,
                            iconColor: Colors.white,
                            color: colorTheme.primary,
                            icon: CupertinoIcons.add,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 6.h),
                  Text(
                    imageFile == null ? 'Добавить фото' : 'Фото выбрано',
                    style: textTheme.bodyLarge!.copyWith(
                      color: colorTheme.onTertiary,
                    ),
                  ),
                  Text(
                    imageFile == null
                        ? 'Нажмите, чтобы выбрать фото'
                        : 'Нажмите, чтобы заменить фото',
                    style: textTheme.bodyLarge!.copyWith(
                      color: colorTheme.secondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddPhotoBadge extends StatelessWidget {
  final Color backgroundColor;
  final Color color;
  final Color iconColor;
  final IconData icon;

  const _AddPhotoBadge({
    required this.backgroundColor,
    required this.color,
    required this.iconColor,
    required this.icon,
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
        child: Icon(icon, color: iconColor),
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
            fontSize: 14,
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
                fontSize: 14,
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
              fontSize: 14,
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
