import 'package:contact_bloc/bloc_pattern/bloc/appstate/appstate_bloc.dart';
import 'package:contact_bloc/bloc_pattern/bloc/contact/contact_bloc.dart';
import 'package:contact_bloc/bloc_pattern/cubit/pageview/pageview_cubit.dart';
import 'package:contact_bloc/database/db.dart';
import 'package:contact_bloc/pages.dart';
import 'package:contact_bloc/repository/repository.dart';
import 'package:contact_bloc/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_pattern/cubit/searches_feature/searches_feature_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository();
    final db = Db();
    final router = AppRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactBloc(db: db)
            ..add(
              LoadContactDatabase(),
            ),
        ),
        BlocProvider(
          create: (context) =>
              AppStateBloc(userRepository: userRepository, db: db)
                ..add(
                  IsUserLoadedEvent(),
                ),
        ),
        BlocProvider(
          create: (context) => PageViewCubit(),
        ),
        BlocProvider(
          create: (context) => SearchesFeatureCubit(db: db),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
            primary: Colors.orange,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Pages(db: db),
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
