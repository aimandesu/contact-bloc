import 'dart:ffi';

import 'package:contact_bloc/bloc_pattern/cubit/update_profile/update_profile_cubit.dart';
import 'package:contact_bloc/screen/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  MaterialPageRoute? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/profile':
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UpdateProfileCubit(),
            child: Profile(
              contact: args['contact'],
              from: args['from'],
            ),
          ),
        );
      // case '/second':
      //   return MaterialPageRoute(
      //     builder: (_) => const SecondScreen(),
      //   );
      // case '/third':
      //   return MaterialPageRoute(
      //     builder: (_) => const ThirdScreen(),
      //   );
      default:
        return null;
    }
  }
}
