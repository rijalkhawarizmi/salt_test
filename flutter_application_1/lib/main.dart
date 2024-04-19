import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/home/presentation/cubit/home/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/injection_container.dart';
import 'src/home/presentation/view/home.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeCubit>()
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
