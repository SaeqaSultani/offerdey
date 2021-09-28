import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/util/bloc/auth/auth_bloc.dart';
import 'core/util/bloc/profile_pic/profilepic_bloc.dart';
import 'core/util/bloc/theme/theme_bloc.dart';
import 'core/util/bloc/user/user_bloc.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
        BlocProvider<ProfilePicBloc>(
          create: (BuildContext context) => ProfilePicBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: () {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Sirate Mustaqeem',
                debugShowCheckedModeBanner: false,
                color: Colors.white,
                theme: state.currentTheme,
                initialRoute: RouteGenerator.splash,
                onGenerateRoute: RouteGenerator.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
