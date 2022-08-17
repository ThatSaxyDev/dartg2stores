import 'package:dart_g2_stores/features/auth/services/auth_services.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_images.dart';
import 'package:dart_g2_stores/shared/widgets/custom_button.dart';
import 'package:dart_g2_stores/shared/widgets/custom_textfield.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Stack(
            children: [
              Positioned(
                left: 27.w,
                child: Image.asset(
                  AppImages.logo,
                  height: 400.h,
                  color: AppColors.primaryBlue,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 300.h,
                    // child: Image.asset(AppImages.logo),
                  ),
                  ListTile(
                    tileColor: Colors.transparent,
                    // _auth == Auth.signup
                    //     ? AppColors.blue02
                    //     : Colors.transparent,
                    title: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    leading: Radio(
                      activeColor: AppColors.primaryBlue,
                      value: Auth.signup,
                      groupValue: _auth,
                      onChanged: (Auth? value) {
                        setState(() {
                          _auth = value!;
                        });
                      },
                    ),
                  ),
                  if (_auth == Auth.signup)
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 10.w,
                      ),
                      // color: AppColors.blue02,
                      child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: 'Name',
                            ),
                            Spc(h: 10.h),
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            Spc(h: 10.h),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              isObscure: true,
                            ),
                            Spc(h: 10.h),
                            CustomButton(
                              text: 'Sign Up',
                              textColor: Colors.white,
                              color: AppColors.primaryBlue,
                              onTap: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ListTile(
                    title: const Text(
                      'Sign-in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Radio(
                      activeColor: AppColors.primaryBlue,
                      value: Auth.signin,
                      groupValue: _auth,
                      onChanged: (Auth? value) {
                        setState(() {
                          _auth = value!;
                        });
                      },
                    ),
                  ),
                  if (_auth == Auth.signin)
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 10.w,
                      ),
                      // color: AppColors.blue02,
                      child: Form(
                        key: _signInFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            Spc(h: 10.h),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              isObscure: true,
                            ),
                            Spc(h: 10.h),
                            CustomButton(
                              text: 'Sign In',
                              textColor: Colors.white,
                              color: AppColors.primaryBlue,
                              onTap: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  signInUser();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
