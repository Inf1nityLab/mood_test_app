import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/presentation/pages/calendar_page.dart';
import 'injection_container.dart' as di;
import 'presentation/bloc/mood_bloc.dart';
import 'presentation/bloc/tab_bloc.dart';
import 'presentation/pages/test_app.dart';
import 'presentation/bloc/time_bloc.dart';

MaterialColor createMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await di.init();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mood Tracker',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//         scaffoldBackgroundColor: const Color(0xFFFFFDFC),
//         fontFamily: GoogleFonts.nunito().fontFamily,
//       ),
//       home: BlocProvider(
//         create: (_) => di.sl<MoodBloc>(),
//         child: const TestApp(),
//       ),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<MoodBloc>()..add(LoadEmotions()),
        ),
        BlocProvider(
          create: (_) => di.sl<TabBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<TimeBloc>(),
        ),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          primarySwatch: createMaterialColor(const Color(0xFFFF8702)),
          scaffoldBackgroundColor: const Color(0xFFFFFDFC),
          fontFamily: GoogleFonts.nunito().fontFamily,
        ),
        darkTheme: ThemeData.dark(),
        home:  const TestApp(),
      ),
    );
  }
}


