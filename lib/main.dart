import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'core/di/locator.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locator.init();
  runApp(const AutoPassportApp());
}

class AutoPassportApp extends StatefulWidget {
  const AutoPassportApp({super.key});

  @override
  State<AutoPassportApp> createState() => _AutoPassportAppState();
}

class _AutoPassportAppState extends State<AutoPassportApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Locator.themeController;

    return Observer(
      builder: (_) {
        return MaterialApp.router(
          title: 'AutoPassport',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          locale: themeController.currentLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}
