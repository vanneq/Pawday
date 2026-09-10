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

class AddCatPage extends StatelessWidget {
  const AddCatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddCatView();
  }
}

class AddCatView extends StatefulWidget {
  const AddCatView({super.key});

  @override
  State<AddCatView> createState() => _AddCatViewState();
}

class _AddCatViewState extends State<AddCatView> {
  final TextEditingController nameController = TextEditingController();
  CatColoration selectedColor = CatColoration.ginger;
  CatCharacter selectedCharacter = CatCharacter.calm;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CatsCubit, CatsState>(
      listener: (context, state) {
        if (state is CatsAdded) {
          if (context.canPop()) {
            showSuccessSnackbar(context, 'Питомец успешно добавлен 🐾');
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
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (context.canPop()) context.pop();
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.arrow_back_ios, size: 26),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Давай познакомимся!',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Как зовут твоего кота?',
                          style: Theme.of(context).textTheme.bodyLarge,
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
                            final isLoading = state is CatsAdding;

                            return PrimaryButton(
                              isActive: nameController.text.trim().isNotEmpty,
                              isLoading: isLoading,
                              text: 'Добавить котика',
                              onPressed: () {
                                context.read<CatsCubit>().addCat(
                                  CreateCatParams(
                                    name: nameController.text,
                                    createdAt: DateTime.now(),
                                    color: selectedColor,

                                    dairyEntries: 0,
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

class _TextFieldName extends StatelessWidget {
  final TextEditingController controller;
  const _TextFieldName({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
