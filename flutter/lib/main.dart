import 'package:ENC/scope/persist_adapter/persist_adapter.dart';
import 'package:ENC/utils/breakpoint/breakpoint.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';
import 'package:ENC/main.controller.dart';

void main() async {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final mainController = MainController();
  final adapter = PersistAdapter.create();

  void init() async {
    mainController.addListener(() => setState(() {}));
    await adapter.init();
    await adapter.notifier?.initial(mainController, adapter);
    final defaultScope = await adapter.getDefaultScope();
    await mainController.handleEnterScope(adapter, defaultScope);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    mainController.dispose();
    adapter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => MultiProvider(
        providers: [
          Provider.value(
            value: BreakPointHelper.calculate(constraints.maxWidth),
          ),
          ListenableProvider.value(value: mainController),
          ListenableProvider.value(value: adapter),
          ListenableProvider.value(value: mainController.scope),
        ],
        builder: (context, _) => MaterialApp.router(
          title: 'ENC',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(
                allowEnterRouteSnapshotting: false,
              ),
              TargetPlatform.windows: ZoomPageTransitionsBuilder(
                allowEnterRouteSnapshotting: false,
              ),
            }),
          ),
          debugShowCheckedModeBanner: false,
          routerDelegate: mainController.rootDelegate,
        ),
      ),
    );
  }
}
