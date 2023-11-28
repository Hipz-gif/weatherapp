import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubit/app_cubit_logics.dart';
import 'package:weatherapp/cubit/app_cubits.dart';
import 'package:weatherapp/services/data_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App with BloC',
      home: BlocProvider<AppCubits>(
        create: (context) => AppCubits(
            data: DataServices()
        ),
        child: AppCubitLogics(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
