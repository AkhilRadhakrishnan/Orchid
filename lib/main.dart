import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/models/nurse.dart';
import 'package:orchid/models/service_slider.dart';
import 'package:orchid/models/specialities.dart';
import 'package:orchid/provider/date_time_provider.dart';
import 'package:orchid/provider/doctor_nurse_provider.dart';
import 'package:orchid/provider/my_appoinment_provider.dart';
import 'package:orchid/provider/slider_provider.dart';
import 'package:orchid/provider/specialities_provider.dart';
import 'package:orchid/views/splash_screen.dart';
import 'package:provider/provider.dart';
import 'models/doctor.dart';
import 'models/services.dart';
import 'models/slider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DoctorModel()),
        ChangeNotifierProvider(
          create: (_) => DoctorProvider(),
        ),
        ChangeNotifierProvider(create: (_) => NurseModel()),
        ChangeNotifierProvider(
          create: (_) => NurseProvider(),
        ),
        ChangeNotifierProvider(create: (_) => SpecialitiesModel()),
        ChangeNotifierProvider(create: (_) => SpecialitiesProvider()),
        ChangeNotifierProvider(create: (_) => SliderModel()),
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => ServicesModel()),
        ChangeNotifierProvider(create: (_) => ServicesProvider()),
        ChangeNotifierProvider(create: (_) => ServiceSliderModel()),
        ChangeNotifierProvider(create: (_) => ServiceSliderProvider()),
        ChangeNotifierProvider(create: (_) => AppoinmentProvider()),
        ChangeNotifierProvider(create: (_) => MyAppoinmentProvider())
      ],
      builder: (context, child) {
        return MaterialApp(
          color: const Color(0xffF2F6F9),
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              toolbarTextStyle: Theme.of(context)
                  .textTheme
                  .apply(
                    bodyColor: bodyTextColor,
                    displayColor: bodyTextColor,
                  )
                  .bodyText2,
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .apply(
                    bodyColor: bodyTextColor,
                    displayColor: bodyTextColor,
                  )
                  .headline6,
            ),
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: bodyTextColor, displayColor: bodyTextColor),
          ),
          title: 'Doctor Consultant',
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
