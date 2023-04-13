import 'package:crud_sneakers/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/sneaker_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SneakerCubit>(
          create: (_) => SneakerCubit()..init(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
