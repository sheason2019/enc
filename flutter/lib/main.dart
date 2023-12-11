import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/scope/scope.collection.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final mainController = MainController(
    onActiveScopeChanged: (scope) async {
      await collection.setDefaultScope(scope);
      setState(() {
        currentScope = scope;
      });
    },
  );
  late final collection = ScopeCollection();
  Scope? currentScope;

  void init() async {
    await collection.updateScopes();
    final defaultScope = await collection.findDefaultScope();
    await mainController.handleEnterScope(defaultScope);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    mainController.dispose();
    collection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: mainController),
        ListenableProvider.value(value: collection),
        ListenableProvider.value(value: currentScope),
      ],
      builder: (context, _) => MaterialApp.router(
        title: 'Sheason Chat',
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
    );
  }
}
