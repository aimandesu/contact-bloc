import 'package:contact_bloc/bloc_pattern/bloc/contact/contact_bloc.dart';
import 'package:contact_bloc/bloc_pattern/cubit/searches_feature/searches_feature_cubit.dart';
import 'package:contact_bloc/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/contact_layout.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchesFeatureCubit, SearchesFeatureState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        if (state is ContactNotFound) {
          return Center(
            child: Text(
              "No Contact Found",
              style: textStyle30,
            ),
          );
        } else if (state is ContactFound) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final contact = state.users![index];
              return ContactLayout(contact: contact);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).colorScheme.primary,
              strokeWidth: 6,
            ),
          );
        }
      },
    );
  }
}
