import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kotik/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_state.dart';

class AuthSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> globalKey;
  final VoidCallback onPressed;
  final String text;
  const AuthSubmitButton({
    super.key,
    required this.globalKey,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pets_rounded,
                  size: 24.r,
                  color: Theme.of(context).colorScheme.surface,
                ),
                SizedBox(width: 6.w),
                isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        text,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
