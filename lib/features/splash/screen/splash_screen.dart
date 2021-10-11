import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/bloc/auth/auth_bloc.dart';
import '../../../routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //if (context.read<AuthBloc>().state is! AuthLoaded) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(RouteGenerator.login);
    });
    //} else {
    //  Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.of(context).pushReplacementNamed(RouteGenerator.home);
    //  });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Image.asset(
            'asset/images/core/png/dawa_hazir_logo.png',
            width: 0.5.sw,
          ),
        ),
      ),
    );
  }
}
