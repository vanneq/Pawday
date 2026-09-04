import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/extension/cat_extension.dart';
import 'package:kotik/core/extension/day_with_cat_extension.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/features/main/presentation/cubit/cats_cubit.dart';
import 'package:kotik/features/main/presentation/cubit/cats_state.dart';
import 'package:kotik/features/profile/presentation/widgets/cat_avatar.dart';
import 'package:kotik/features/profile/presentation/widgets/cat_selector.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Профиль',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: false,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: InkWell(
              child: Icon(
                Icons.settings_outlined,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 0),
                  child: Column(
                    children: [
                      BlocBuilder<CatsCubit, CatsState>(
                        builder: (context, state) {
                          if (state is CatsLoading) {
                            return const CircularProgressIndicator();
                          }

                          if (state is CatsLoadedData) {
                            return Column(
                              children: [
                                _ProfileCard(selectCat: state.selectedCat),
                                SizedBox(height: 18.h),
                                CatList(
                                  cats: state.cats,
                                  selectedCatId: state.selectedCat?.id,
                                ),
                              ],
                            );
                          }

                          return Column(
                            children: [
                              const _ProfileCard(),
                              SizedBox(height: 18.h),
                              const CatList(cats: []),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 18.h),
                      SettingsColumn(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final CatModel? selectCat;

  const _ProfileCard({this.selectCat});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: colorScheme.onPrimary.withAlpha(160),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Row(
            children: [
              CatAvatar(
                asset:
                    selectCat?.color.imagePath ?? 'assets/cats/empty_cat.png',
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectCat?.name ?? 'Добавьте меня 🐈',
                            style: textTheme.bodyLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        selectCat != null
                            ? InkWell(child: Icon(Icons.edit_outlined))
                            : const SizedBox.shrink(),
                      ],
                    ),
                    Text(
                      selectCat?.color.title != null
                          ? '${selectCat?.color.title} кот'
                          : 'Добавьте меня 🐈',
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: colorScheme.outline.withAlpha(60),
            border: Border.all(color: colorScheme.outline),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 26,
                      color: colorScheme.onTertiary,
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Дней с котом',
                          style: textTheme.bodyMedium!.copyWith(fontSize: 14),
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                        Text(
                          '${selectCat?.daysWithCat ?? 0}',
                          style: textTheme.bodyLarge!.copyWith(
                            color: colorScheme.onTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 26,
                      color: colorScheme.onTertiary,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Создано записей',
                            style: textTheme.bodyMedium!.copyWith(fontSize: 14),
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                          ),
                          Text(
                            '${selectCat?.dairyEntries ?? 0}',
                            style: textTheme.bodyLarge!.copyWith(
                              color: colorScheme.onTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CatList extends StatelessWidget {
  final String? selectedCatId;
  final List<CatModel> cats;

  const CatList({super.key, required this.cats, this.selectedCatId});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Мои котики',
              style: textTheme.bodyLarge!.copyWith(fontSize: 18),
            ),
            InkWell(
              child: Text(
                'Управление',
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        CatSelector(
          selectedCatId: selectedCatId,
          cats: cats,
          onCatTap: (cat) {
            context.read<CatsCubit>().selectCat(cat);
          },
          onAddCatTap: () {
            context.push('/profile/add_cat');
          },
        ),
      ],
    );
  }
}

class SettingsColumn extends StatelessWidget {
  static final items = [
    SettingItemsData(
      title: 'Аккаунт',
      onTap: () {},
      icon: CupertinoIcons.person,
    ),
    SettingItemsData(
      title: 'Уведомления',
      onTap: () {},
      icon: CupertinoIcons.bell,
    ),
    SettingItemsData(
      title: 'Поддержка',
      onTap: () {},
      icon: CupertinoIcons.heart,
    ),
    SettingItemsData(
      title: 'О приложении',
      onTap: () {},
      icon: CupertinoIcons.doc,
    ),
  ];
  const SettingsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: colorScheme.onPrimary.withAlpha(160),
        border: Border.all(color: colorScheme.outline.withAlpha(150), width: 1),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = items[index];
          return SettingsItem(
            title: item.title,
            onTap: item.onTap,
            icon: item.icon,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1, color: colorScheme.outline);
        },
        itemCount: items.length,
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;
  const SettingsItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onTertiary.withAlpha(220),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.onTertiary.withAlpha(220),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingItemsData {
  final String title;
  final VoidCallback onTap;
  final IconData icon;

  SettingItemsData({
    required this.title,
    required this.onTap,
    required this.icon,
  });
}
