import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/app/theme/colors.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_state.dart';
import 'package:kotik/features/auth/presentation/pages/widgets/auth_submit_button.dart';
import 'package:kotik/features/auth/presentation/pages/widgets/auth_text_field.dart';
import 'package:kotik/features/auth/presentation/validators/auth_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;
  var error = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) context.go('/main');
            if (state is AuthLoading) {
              setState(() {
                error = '';
              });
            } else if (state is AuthError) {
              setState(() {
                error = state.error;
              });
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                top: 200.h,
                child: Image.asset(
                  'assets/auth_image.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(
                              24.w,
                              100.h,
                              24.w,
                              16.h,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Регистрация',
                                  style: textTheme.displayLarge,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Создай аккаунт, чтобы\nсохранить все приключения кота 🐾',
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    height: 1.25,
                                  ),
                                ),
                                SizedBox(height: 42.h),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                    18.w,
                                    26.h,
                                    18.w,
                                    16.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondary.withAlpha(230),
                                    borderRadius: BorderRadius.circular(14.r),
                                    border: Border.all(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outline.withAlpha(150),
                                    ),
                                  ),
                                  child: Form(
                                    key: globalKey,
                                    child: Column(
                                      children: [
                                        AuthTextField(
                                          controller: emailController,
                                          validator: (value) =>
                                              AuthValidators.email(value),
                                          hintText: 'Email',
                                          icon: Icons.mail_outline_rounded,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                        SizedBox(height: 14.h),
                                        AuthTextField(
                                          controller: passwordController,
                                          validator: (value) =>
                                              AuthValidators.password(value),
                                          hintText: 'Пароль',
                                          icon: Icons.lock_outline_rounded,
                                          obscureText: _obscurePassword,
                                          trailing: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword =
                                                    !_obscurePassword;
                                              });
                                            },
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                        .visibility_off_outlined,
                                            ),
                                            color: navColor,
                                            tooltip: _obscurePassword
                                                ? 'Показать пароль'
                                                : 'Скрыть пароль',
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        AuthTextField(
                                          controller: confirmPasswordController,
                                          validator: (value) =>
                                              AuthValidators.confirmPassword(
                                                value,
                                                passwordController.text,
                                              ),
                                          hintText: 'Повторите пароль',
                                          icon: Icons.lock_outline_rounded,
                                          obscureText: _obscureRepeatPassword,
                                          trailing: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureRepeatPassword =
                                                    !_obscureRepeatPassword;
                                              });
                                            },
                                            icon: Icon(
                                              _obscureRepeatPassword
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                        .visibility_off_outlined,
                                            ),
                                            color: navColor,
                                            tooltip: _obscureRepeatPassword
                                                ? 'Показать пароль'
                                                : 'Скрыть пароль',
                                          ),
                                        ),
                                        SizedBox(height: 24.h),
                                        SizedBox(
                                          width: double.infinity,
                                          child: AuthSubmitButton(
                                            text: 'Создать аккаунт',
                                            globalKey: globalKey,
                                            onPressed: () {
                                              context
                                                  .read<AuthCubit>()
                                                  .register(
                                                    emailController.text,
                                                    passwordController.text,
                                                    confirmPasswordController
                                                        .text,
                                                  );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        Text.rich(
                                          TextSpan(
                                            text:
                                                'Регистрируясь, вы соглашаетесь с\n',
                                            style: textTheme.bodySmall
                                                ?.copyWith(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                                  height: 1.25,
                                                ),
                                            children: [
                                              TextSpan(
                                                text: 'Условиями использования',
                                                style: textTheme.bodySmall
                                                    ?.copyWith(
                                                      color: primaryColor,
                                                      height: 1.25,
                                                    ),
                                              ),
                                              const TextSpan(text: ' и '),
                                              TextSpan(
                                                text:
                                                    'Политикой конфиденциальности',
                                                style: textTheme.bodySmall
                                                    ?.copyWith(
                                                      color: primaryColor,
                                                      height: 1.25,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 8.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Уже есть аккаунт?',
                                              softWrap: true,
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(
                                                    color: mainTextColor
                                                        .withValues(
                                                          alpha: 0.78,
                                                        ),
                                                    fontSize: 15.sp,
                                                  ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.go('/login');
                                              },
                                              style: TextButton.styleFrom(
                                                foregroundColor: primaryColor,
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                visualDensity:
                                                    VisualDensity.compact,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 6.w,
                                                ),
                                                minimumSize: Size.zero,
                                              ),
                                              child: Text(
                                                'Мяути',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                      color: primaryColor,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        if (error.length >= 2)
                                          Text(
                                            error,
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.error,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6.h),
                              ],
                            ),
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
      ),
    );
  }
}
