import 'package:flutter/material.dart';

import 'core/constants/app_strings.dart';
import 'core/constants/app_theme.dart';
import 'pages/splash/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const RanmaNotesApp());
}

class RanmaNotesApp extends StatelessWidget {
  const RanmaNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // Tema Aplikasi
      theme: AppTheme.lightTheme,

      // Mengaktifkan dukungan gesture drag untuk berbagai tipe perangkat (Desktop/Tablet/Mobile)
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
      ),

      // Pembungkus responsif global untuk membatasi lebar maksimum pada layar ekstra besar (Tablet/Foldable/Desktop)
      builder: (context, child) {
        return MediaQuery(
          // Memastikan faktor skala teks tetap konsisten di berbagai kerapatan layar
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },

      home: const SplashPage(),
    );
  }
}
