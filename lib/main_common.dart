import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:se7ety/core/presentation/cubit/theme_cubit/theme_states.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/sharedpref.dart';
import 'package:se7ety/core/utils/themes.dart';
import 'package:se7ety/environment_config.dart';
import 'package:se7ety/firebase_options.dart';

void mainCommon(EnvironmentConfig environmentConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPref.initSharedPref();
  //here you can use return stage firebase id  when you run staging app
  // getFireBaseId(environmentConfig);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    // DevicePreview(
    //   enabled: false,

    // builder: (context) =>
    EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path: "assets/translations",
      fallbackLocale: Locale('ar'),
      child: const Se7ety(),
    ),
    // ),
  );
}

class Se7ety extends StatelessWidget {
  const Se7ety({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeStates>(
        builder: (context, state) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale:
                // DevicePreview.isEnabled(context)
                // ? DevicePreview.locale(context) :
                context.locale,
            // builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            routerConfig: Routes.appRoutes,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            themeMode: context.read<ThemeCubit>().isDark
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
