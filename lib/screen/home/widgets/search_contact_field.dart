import 'package:contact_bloc/bloc_pattern/cubit/searches_feature/searches_feature_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc_pattern/bloc/contact/contact_bloc.dart';
import '../../../constant.dart';

class SearchContactField extends StatelessWidget {
  const SearchContactField({
    super.key,
    required this.focusNode,
    required this.searchController,
    required this.searchOn,
    required this.closeSearch,
  });

  final FocusNode focusNode;
  final TextEditingController searchController;
  final bool searchOn;
  final VoidCallback closeSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationCircular(Colors.white, 35),
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 20,
        left: 25,
        right: 25,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        focusNode: focusNode,
        controller: searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search Contact",
          suffixIcon: Container(
            width: 80,
            margin: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.search),
                searchOn
                    ? IconButton(
                        onPressed: closeSearch,
                        icon: const Icon(Icons.close),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        onChanged: (value) {
          context.read<SearchesFeatureCubit>().searchingContact(
                searchController.text,
              );
          //not really sure, should we fire event?
        },
      ),
    );
  }
}
