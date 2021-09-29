import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/bloc/auth/auth_bloc.dart';
import '../../../routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is NoAuth) {
          Navigator.of(context).pushReplacementNamed(RouteGenerator.login);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: 1.sw,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Home'),
                    ElevatedButton(
                      onPressed: () {
                        // context
                        //     .read<UserBloc>()
                        //     .add(const LogoutWithFacebook());
                      },
                      child: Text('Logout with facebook'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //context.read<UserBloc>().add(const LogoutWithGoogle());
                      },
                      child: Text('Logout with google'),
                    ),
                    if (state is AuthLoaded)
                      Column(
                        children: [
                          Text(state.auth.riderId.toString()),
                        ],
                      )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
