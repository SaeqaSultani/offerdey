import '../../../core/network/params.dart';
import '../../../core/util/bloc/auth/auth_bloc.dart';
import '../../../core/util/constants.dart';
import '../widget/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen();

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The reset password link is sent to your email.'),
            ),
          );
          Navigator.of(context).pop();
        }
        if (state is NoAuth) {
          if (state.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure!.message),
              ),
            );
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 0.3.sh,
                  child: Center(
                    child: LottieBuilder.asset(
                      'asset/images/auth/lottie_json/login_animation.json',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: kPagePadding,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.h,
                          ),
                          Text(
                            'Forget Password',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            'Please enter your registered email address to receive a reset password link.',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          AuthTextField(
                            controller: emailController,
                            hintText: 'Email Address',
                            icon: 'asset/images/auth/svg/email.svg',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    ForgetPassword(
                                      ForgotPasswordParam(
                                        email: emailController.text,
                                      ),
                                    ),
                                  );
                            },
                            child: const Text(
                              'Reset',
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Remember your password now? '),
                                    Text(
                                      'Login!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
