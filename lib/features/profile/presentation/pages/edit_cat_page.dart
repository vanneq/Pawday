import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/extension/cat_extension.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/core/widgets/primary_button.dart';
import 'package:kotik/core/widgets/snackbar.dart';
import 'package:kotik/features/main/presentation/cubit/cats_cubit.dart';
import 'package:kotik/features/main/presentation/cubit/cats_state.dart';
import 'package:kotik/features/profile/presentation/widgets/cat_avatar.dart';

class EditCatPage extends StatefulWidget {
  final CatModel cat;

  const EditCatPage({super.key, required this.cat});

  @override
  State<EditCatPage> createState() => _EditCatPageState();
}

class _EditCatPageState extends State<EditCatPage> {
  late final TextEditingController nameController;
  late CatColoration selectedColor;
  late CatCharacter selectedCharacter;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.cat.name);
    selectedColor = widget.cat.color;
    selectedCharacter = widget.cat.character ?? CatCharacter.calm;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _showDeleteCatDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => _DeleteCatDialog(cat: widget.cat),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CatsCubit, CatsState>(
      listener: (context, state) {
        if (state is CatsEdited) {
          if (context.canPop()) {
            showSuccessSnackbar(context, 'Питомец успешно обновлен 🐾');
            context.pop();
          }
        }
        if (state is CatsError) {
          showErrorSnackbar(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  if (context.canPop()) context.pop();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(6.w),
                                  child: Icon(Icons.arrow_back_ios, size: 26),
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: _showDeleteCatDialog,
                                child: Padding(
                                  padding: EdgeInsets.all(6.w),
                                  child: Icon(
                                    Icons.remove_circle_outline,
                                    color: Theme.of(context).colorScheme.error,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Редактировать котика',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),

                        SizedBox(height: 16.h),
                        _TextFieldName(controller: nameController),
                        SizedBox(height: 16.h),
                        CatColorationGrid(
                          selectedColor: selectedColor,
                          onChanged: (color) {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                        ),
                        SizedBox(height: 20.h),
                        CharacterRow(
                          selectedCharacter: selectedCharacter,
                          onChanged: (character) {
                            setState(() {
                              selectedCharacter = character;
                            });
                          },
                        ),
                        SizedBox(height: 24.h),
                        BlocBuilder<CatsCubit, CatsState>(
                          builder: (context, state) {
                            final isLoading = state is CatsEditing;

                            return PrimaryButton(
                              isActive: nameController.text.trim().isNotEmpty,
                              isLoading: isLoading,
                              text: 'Редактировать котика',
                              onPressed: () {
                                context.read<CatsCubit>().updateCat(
                                  widget.cat.copyWith(
                                    color: selectedColor,
                                    character: selectedCharacter,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 14.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DeleteCatDialog extends StatefulWidget {
  final CatModel cat;
  const _DeleteCatDialog({required this.cat});

  @override
  State<_DeleteCatDialog> createState() => _DeleteCatDialogState();
}

class _DeleteCatDialogState extends State<_DeleteCatDialog> {
  static const _initialSeconds = 10;

  Timer? _timer;
  int _secondsLeft = _initialSeconds;

  bool get _canRemove => _secondsLeft == 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() {
          _secondsLeft = 0;
        });
        return;
      }

      setState(() {
        _secondsLeft--;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 14.h),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colorScheme.outline.withAlpha(140)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(24),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 54.w,
              height: 54.w,
              decoration: BoxDecoration(
                color: colorScheme.error.withAlpha(24),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.remove_circle_outline,
                color: colorScheme.error,
                size: 30,
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Убрать котика из профиля?',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            Text(
              'После удаления данные нельзя будет восстановить',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text('Отмена'),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _canRemove
                        ? () {
                            context.read<CatsCubit>().deleteCat(widget.cat.id);
                            context.go('/profile');
                            showSuccessSnackbar(
                              context,
                              'Ваш котик ${widget.cat.name} был удален',
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      disabledBackgroundColor: colorScheme.error.withAlpha(110),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      _canRemove ? 'Убрать' : 'Убрать ($_secondsLeft)',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TextFieldName extends StatelessWidget {
  final TextEditingController controller;
  const _TextFieldName({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          enabled: false,
          controller: controller,
          maxLength: 22,
          decoration: InputDecoration(
            counterText: '',
            suffixIcon: Icon(
              Icons.pets,
              size: 26,
              color: colorScheme.secondary.withAlpha(170),
            ),
            filled: true,
            fillColor: colorScheme.onPrimary,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Имя котика неизменяемо',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}

class CatColorationGrid extends StatelessWidget {
  final CatColoration selectedColor;
  final ValueChanged<CatColoration> onChanged;

  const CatColorationGrid({
    super.key,
    required this.selectedColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CatColoration.values;

    return Column(
      children: [
        Text('Выберите окрас', style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: 10.h),
        LayoutBuilder(
          builder: (context, constraints) {
            final gap = 8.w;
            final itemWidth = (constraints.maxWidth - gap * 2) / 3;
            final avatarSize = itemWidth.clamp(48.0, 78.0);

            Widget buildColorItem(CatColoration color) {
              final isSelected = selectedColor == color;
              return SizedBox(
                width: itemWidth,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        onChanged(color);
                      },
                      child: CatAvatar(
                        width: avatarSize,
                        height: avatarSize,
                        asset: color.imagePath,
                        withAlpha: false,
                        widthBorder: 2,
                        isSelected: isSelected,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      color.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }

            Widget buildColorRow(Iterable<CatColoration> rowColors) {
              final row = rowColors.toList();

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < row.length; i++) ...[
                    buildColorItem(row[i]),
                    if (i != row.length - 1) SizedBox(width: gap),
                  ],
                ],
              );
            }

            return Column(
              children: [
                buildColorRow(colors.take(2)),
                SizedBox(height: gap),
                buildColorRow(colors.skip(2).take(3)),
                SizedBox(height: gap),
                buildColorRow(colors.skip(5).take(2)),
              ],
            );
          },
        ),
      ],
    );
  }
}

class CharacterRow extends StatelessWidget {
  final CatCharacter selectedCharacter;
  final ValueChanged<CatCharacter> onChanged;

  const CharacterRow({
    super.key,
    required this.selectedCharacter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Выберите характер', style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: CatCharacter.values.map((character) {
            return GestureDetector(
              onTap: () => onChanged(character),
              child: CharacterItem(
                isSelected: selectedCharacter == character,
                title: character.title,
                character: character,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CharacterItem extends StatelessWidget {
  final String title;
  final CatCharacter character;
  final bool isSelected;

  const CharacterItem({
    super.key,
    required this.title,
    required this.character,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : Theme.of(context).colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Text(
        title,
        style: isSelected
            ? Theme.of(context).textTheme.labelLarge
            : Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
