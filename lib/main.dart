import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/models/scan_model.dart';
import 'presentation/screens/home_screen.dart';
import 'data/datasources/local_datasource.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  Hive.registerAdapter(ScanModelAdapter()); 

  await Hive.openBox<ScanModel>(LocalDataSource.boxName);

  runApp(const ProviderScope(child: SnapFactsApp()));
}

class SnapFactsApp extends StatelessWidget {
  const SnapFactsApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapFacts',
      theme: ThemeData(
        useMaterial3: true, 
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)
      ),
      home: const HomeScreen(),
    );
  }
}