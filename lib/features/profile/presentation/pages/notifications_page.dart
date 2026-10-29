import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/services/notification_sevice.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _notificationsEnabled = false;
  bool _isLoading = true;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _loadNotificationStatus();
  }

  Future<void> _loadNotificationStatus() async {
    try {
      final isEnabled = await NotificationService.areNotificationsEnabled();
      if (!mounted) return;
      setState(() {
        _notificationsEnabled = isEnabled;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _changeNotificationStatus(bool enabled) async {
    setState(() => _isUpdating = true);

    try {
      final isEnabled = await NotificationService.setNotificationsEnabled(
        enabled,
      );
      if (!mounted) return;

      setState(() => _notificationsEnabled = isEnabled);
      if (enabled && !isEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Разрешите уведомления в системном запросе или настройках телефона.',
            ),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось изменить настройки уведомлений.')),
      );
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

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
                  Text('Уведомления', style: textTheme.headlineLarge),
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
                        Icons.notifications_active_outlined,
                        color: colorScheme.primary,
                        size: 40.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Будьте на связи с котиком',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Включите уведомления, чтобы не пропустить важное от PawDay.',
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
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withAlpha(150),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: colorScheme.outline.withAlpha(130)),
                ),
                child: SwitchListTile.adaptive(
                  value: _notificationsEnabled,
                  onChanged: _isLoading || _isUpdating
                      ? null
                      : _changeNotificationStatus,
                  activeTrackColor: colorScheme.primary,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  secondary: _isLoading || _isUpdating
                      ? SizedBox(
                          width: 22.w,
                          height: 22.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colorScheme.primary,
                          ),
                        )
                      : Icon(
                          Icons.notifications_outlined,
                          color: colorScheme.primary,
                        ),
                  title: Text(
                    'Push-уведомления',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    'Включить или отключить уведомления PawDay',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withAlpha(160),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withAlpha(130),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: colorScheme.outline.withAlpha(110)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: colorScheme.primary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Разрешение на уведомления также можно изменить в настройках телефона.',
                        style: textTheme.bodySmall?.copyWith(
                          height: 1.4,
                          color: colorScheme.onSurface.withAlpha(175),
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
