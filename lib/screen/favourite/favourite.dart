import 'package:contact_bloc/constant.dart';
import 'package:flutter/material.dart';

import '../../widget/contact_layout.dart';
import '../../model/user_model.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key, required this.contact});

  final List<UserModel> contact;

  @override
  Widget build(BuildContext context) {
    return contact.isNotEmpty
        ? ListView.builder(
            itemCount: contact.length,
            itemBuilder: (context, index) {
              final contactObject = contact[index];
              return ContactLayout(contact: contactObject);
            },
          )
        : Center(
            child: Text(
              "no fav contacts",
              style: textStyle30,
            ),
          );
  }
}
