import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tareas/screens/spash_screen.dart';
import 'package:tareas/themes/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<ThemeChanger>(
            create: (_) => ThemeChanger(
                  ThemeData.light(),
                )),
      ],
      child: Builder(builder: (BuildContext context) {
        final _theme = Provider.of<ThemeChanger>(context).getTheme();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _theme,
          home: SplashScreen(),
        );
      }),
    );
  }
}
