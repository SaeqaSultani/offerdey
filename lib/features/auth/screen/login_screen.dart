import 'package:dawahazir_rider/features/adding_list/screen/adding_list.dart';
import 'package:dawahazir_rider/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import '../../../core/network/params.dart';
import '../../../core/util/bloc/auth/auth_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/controller/auth_controller.dart';
import '../../../routes/routes.dart';
import '../widget/auth_text_field.dart';
import '../widget/password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final AuthController authController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    authController = AuthController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => SpinKitRotatingCircle(
              color: Colors.white,
              size: 48.sp,
            ),
          );
        }
        if (state is AuthLoaded) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(RouteGenerator.home);
        } else if (state is NoAuth) {
          Navigator.of(context).pop();
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
                    child: Image.asset(
                      'asset/images/core/png/dawa_hazir_logo.png',
                      width: 0.5.sw,
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
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          AuthTextField(
                            controller: emailController,
                            hintText: 'Phone No',
                            icon: 'asset/images/auth/svg/phone.svg',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          PasswordField(
                            controller: passwordController,
                            hintText: 'Password',
                            icon: 'asset/images/auth/svg/password.svg',
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) {
                              context.read<AuthBloc>().add(
                                    LoginWithEmail(
                                      LoginParam(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    ),
                                  );
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RouteGenerator.forgetPw);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          ElevatedButton(
                            onPressed: () {

                              Navigator.push(
                                  context,MaterialPageRoute(builder: (context) => AddingList()
                              ),);
                              // context.read<AuthBloc>().add(
                              //       LoginWithEmail(
                              //         LoginParam(
                              //           email: emailController.text,
                              //           password: passwordController.text,
                              //         ),
                              //       ),
                              //     );
                            },
                            child: const Text(
                              'Login',
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
                                  Navigator.of(context).pushReplacementNamed(
                                      RouteGenerator.signup);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Don\'t have an account yet? '),
                                    Text(
                                      'Sign up!',
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
