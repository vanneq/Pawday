import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const _months = [
  'января',
  'февраля',
  'марта',
  'апреля',
  'мая',
  'июня',
  'июля',
  'августа',
  'сентября',
  'октября',
  'ноября',
  'декабря',
];

const _monthNames = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь',
];

const _weekdays = [
  'понедельник',
  'вторник',
  'среда',
  'четверг',
  'пятница',
  'суббота',
  'воскресенье',
];

const _weekdaysShort = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'];

typedef CalendarSectionContentBuilder =
    Widget Function(BuildContext context, DateTime selectedDate);

class CalendarSection extends StatefulWidget {
  final CalendarSectionContentBuilder builder;
  final DateTime? initialSelected;
  final ValueChanged<DateTime>? onDateChanged;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final TextStyle? headerStyle;
  final Widget? calendarIcon;
  final double calendarButtonRadius;

  const CalendarSection({
    super.key,
    required this.builder,
    this.initialSelected,
    this.onDateChanged,
    this.height,
    this.padding,
    this.headerStyle,
    this.calendarIcon,
    this.calendarButtonRadius = 12,
  });

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialSelected ?? DateTime.now();
  }

  DateTime get _weekStart {
    final date = _selectedDate;
    return DateTime(date.year, date.month, date.day - date.weekday + 1);
  }

  String get _headerText {
    final selectedDate = _selectedDate;
    final day = selectedDate.day;
    final month = _months[selectedDate.month - 1];

    if (DateUtils.isSameDay(selectedDate, DateTime.now())) {
      return 'Сегодня, $day $month';
    }

    final weekday = _weekdays[selectedDate.weekday - 1];
    final capitalized = weekday[0].toUpperCase() + weekday.substring(1);
    return '$capitalized, $day $month';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final weekDays = List.generate(7, (i) => _weekStart.add(Duration(days: i)));
    final content = widget.builder(context, _selectedDate);

    return Container(
      height: widget.height,
      padding:
          widget.padding ??
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: colorScheme.onSecondary.withAlpha(210),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: colorScheme.outline.withAlpha(95)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(16),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CalendarHeader(
            title: _headerText,
            titleStyle:
                widget.headerStyle ??
                textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onTertiary,
                  fontWeight: FontWeight.w800,
                ),
            icon: widget.calendarIcon,
            buttonRadius: widget.calendarButtonRadius,
            onTap: _pickDate,
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDays.map(_buildDayItem).toList(),
          ),
          SizedBox(height: 14.h),
          Divider(height: 1, color: colorScheme.outline.withAlpha(75)),
          SizedBox(height: 14.h),
          if (widget.height == null) content else Expanded(child: content),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return _AppCalendarDatePicker(
          initialSelected: _selectedDate,
          onConfirmed: (date) {
            if (!mounted) return;
            _selectDate(date);
          },
        );
      },
    );
  }

  Widget _buildDayItem(DateTime date) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = DateUtils.isSameDay(date, _selectedDate);
    final isToday = DateUtils.isSameDay(date, DateTime.now());
    final isWeekend = date.weekday >= DateTime.saturday;

    return GestureDetector(
      onTap: () => _selectDate(date),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 40.w,
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : isToday
              ? colorScheme.primary.withAlpha(28)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isToday && !isSelected
                ? colorScheme.primary.withAlpha(90)
                : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            Text(
              _weekdaysShort[date.weekday - 1],
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimary
                    : isWeekend
                    ? colorScheme.primary.withAlpha(190)
                    : colorScheme.secondary,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              date.day.toString().padLeft(2, '0'),
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onTertiary,
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(DateTime date) {
    setState(() => _selectedDate = date);
    widget.onDateChanged?.call(date);
  }
}

class _CalendarHeader extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final Widget? icon;
  final double buttonRadius;
  final VoidCallback onTap;

  const _CalendarHeader({
    required this.title,
    required this.titleStyle,
    required this.icon,
    required this.buttonRadius,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(child: Text(title, style: titleStyle)),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(buttonRadius.r),
            child: Ink(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: colorScheme.surface.withAlpha(205),
                borderRadius: BorderRadius.circular(buttonRadius.r),
                border: Border.all(color: colorScheme.outline.withAlpha(90)),
              ),
              child: Center(
                child:
                    icon ??
                    Icon(
                      CupertinoIcons.calendar,
                      size: 20.sp,
                      color: colorScheme.primary,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppCalendarDatePicker extends StatefulWidget {
  final DateTime initialSelected;
  final ValueChanged<DateTime> onConfirmed;

  const _AppCalendarDatePicker({
    required this.initialSelected,
    required this.onConfirmed,
  });

  @override
  State<_AppCalendarDatePicker> createState() => _AppCalendarDatePickerState();
}

class _AppCalendarDatePickerState extends State<_AppCalendarDatePicker> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;

  final _monthKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialSelected;
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  Future<void> _showMonthMenu() async {
    final box = _monthKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    final position = box.localToGlobal(Offset.zero);
    final size = box.size;
    final screenWidth = MediaQuery.of(context).size.width;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final month = await showMenu<int>(
      context: context,
      color: colorScheme.onSecondary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      constraints: BoxConstraints(maxHeight: 260.h),
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + size.height + 6.h,
        screenWidth - position.dx - size.width,
        0,
      ),
      items: List.generate(
        12,
        (index) => PopupMenuItem<int>(
          value: index + 1,
          height: 40.h,
          child: Center(
            child: Text(
              _monthNames[index],
              style: textTheme.bodyMedium?.copyWith(
                color: index + 1 == _displayedMonth.month
                    ? colorScheme.primary
                    : colorScheme.onTertiary,
                fontWeight: index + 1 == _displayedMonth.month
                    ? FontWeight.w800
                    : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );

    if (!mounted || month == null) return;
    setState(() => _displayedMonth = DateTime(_displayedMonth.year, month));
  }

  void _changeMonth(int offset) {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + offset,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          color: colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: colorScheme.outline.withAlpha(90)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(28),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PickerTitle(onClose: () => Navigator.of(context).pop()),
            SizedBox(height: 16.h),
            _MonthNavigator(
              monthKey: _monthKey,
              displayedMonth: _displayedMonth,
              onPrevious: () => _changeMonth(-1),
              onNext: () => _changeMonth(1),
              onMonthTap: _showMonthMenu,
            ),
            SizedBox(height: 14.h),
            _WeekdayRow(),
            SizedBox(height: 8.h),
            _PickerCalendarGrid(
              displayedMonth: _displayedMonth,
              selectedDate: _selectedDate,
              onDayTap: (date) {
                setState(() {
                  _selectedDate = DateTime(date.year, date.month, date.day);
                  _displayedMonth = DateTime(date.year, date.month);
                });
              },
            ),
            SizedBox(height: 18.h),
            _ConfirmDateButton(
              onPressed: () {
                widget.onConfirmed(_selectedDate);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerTitle extends StatelessWidget {
  final VoidCallback onClose;

  const _PickerTitle({required this.onClose});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            'Календарь',
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onTertiary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        IconButton(
          onPressed: onClose,
          icon: Icon(
            CupertinoIcons.xmark,
            size: 18.sp,
            color: colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}

class _MonthNavigator extends StatelessWidget {
  final GlobalKey monthKey;
  final DateTime displayedMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onMonthTap;

  const _MonthNavigator({
    required this.monthKey,
    required this.displayedMonth,
    required this.onPrevious,
    required this.onNext,
    required this.onMonthTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        _MonthArrowButton(
          icon: CupertinoIcons.chevron_left,
          onTap: onPrevious,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: GestureDetector(
            onTap: onMonthTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              key: monthKey,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: colorScheme.surface.withAlpha(190),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: colorScheme.outline.withAlpha(90)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_monthNames[displayedMonth.month - 1]} ${displayedMonth.year}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onTertiary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 14.sp,
                    color: colorScheme.secondary,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        _MonthArrowButton(
          icon: CupertinoIcons.chevron_right,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _MonthArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MonthArrowButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          width: 38.r,
          height: 38.r,
          decoration: BoxDecoration(
            color: colorScheme.primary.withAlpha(24),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, size: 18.sp, color: colorScheme.primary),
        ),
      ),
    );
  }
}

class _WeekdayRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: _weekdaysShort
          .map(
            (day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.secondary,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PickerCalendarGrid extends StatelessWidget {
  final DateTime displayedMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDayTap;

  const _PickerCalendarGrid({
    required this.displayedMonth,
    required this.selectedDate,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final year = displayedMonth.year;
    final month = displayedMonth.month;
    final firstDay = DateTime(year, month);
    final previousMonthOffset = firstDay.weekday - 1;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final lastDayPreviousMonth = DateTime(year, month, 0).day;
    final totalUsed = previousMonthOffset + daysInMonth;
    final nextMonthDays = totalUsed % 7 == 0 ? 0 : 7 - totalUsed % 7;
    final totalCells = totalUsed + nextMonthDays;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 5.w,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        late DateTime date;
        late bool isCurrentMonth;

        if (index < previousMonthOffset) {
          final day = lastDayPreviousMonth - previousMonthOffset + 1 + index;
          date = DateTime(year, month - 1, day);
          isCurrentMonth = false;
        } else if (index < totalUsed) {
          final day = index - previousMonthOffset + 1;
          date = DateTime(year, month, day);
          isCurrentMonth = true;
        } else {
          final day = index - totalUsed + 1;
          date = DateTime(year, month + 1, day);
          isCurrentMonth = false;
        }

        return _PickerDayCell(
          date: date,
          isCurrentMonth: isCurrentMonth,
          isSelected: DateUtils.isSameDay(date, selectedDate),
          isToday: DateUtils.isSameDay(date, DateTime.now()),
          onTap: () => onDayTap(date),
        );
      },
    );
  }
}

class _PickerDayCell extends StatelessWidget {
  final DateTime date;
  final bool isCurrentMonth;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  const _PickerDayCell({
    required this.date,
    required this.isCurrentMonth,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : isToday
              ? colorScheme.primary.withAlpha(25)
              : colorScheme.surface.withAlpha(145),
          shape: BoxShape.circle,
          border: Border.all(
            color: isToday && !isSelected
                ? colorScheme.primary.withAlpha(90)
                : Colors.transparent,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          '${date.day}',
          style: textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? colorScheme.onPrimary
                : isCurrentMonth
                ? colorScheme.onTertiary
                : colorScheme.secondary.withAlpha(110),
            fontSize: 13.sp,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ConfirmDateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ConfirmDateButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Подтвердить',
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

String calendarShortMonth(DateTime date) => _months[date.month - 1];
