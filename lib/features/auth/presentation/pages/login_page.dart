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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  var error = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

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
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(24.w, 100.h, 24.w, 0),
                          child: Column(
                            children: [
                              Text('Вход', style: textTheme.displayLarge),
                              SizedBox(height: 10.h),
                              Text(
                                'Войдите в аккаунт, чтобы\nсохранить все приключения кота 🐾',
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
                                                : Icons.visibility_off_outlined,
                                          ),
                                          color: navColor,
                                          tooltip: _obscurePassword
                                              ? 'Показать пароль'
                                              : 'Скрыть пароль',
                                        ),
                                      ),
                                      SizedBox(height: 24.h),
                                      SizedBox(
                                        width: double.infinity,
                                        child: AuthSubmitButton(
                                          text: 'Войти в аккаунт',
                                          globalKey: globalKey,
                                          onPressed: () {
                                            context.read<AuthCubit>().login(
                                              emailController.text,
                                              passwordController.text,
                                            );
                                          },
                                        ),
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
                                      SizedBox(height: 8.h),
                                      Text.rich(
                                        TextSpan(
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: mainTextColor.withValues(
                                              alpha: 0.78,
                                            ),
                                            fontSize: 15.sp,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text:
                                                  'Еще не присоединились к нам? ',
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: GestureDetector(
                                                onTap: () {
                                                  context.go('/register');
                                                },
                                                child: Text(
                                                  'Замяугистрироваться',
                                                  style: textTheme.bodyMedium
                                                      ?.copyWith(
                                                        color: primaryColor,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
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
