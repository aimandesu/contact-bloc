import 'package:contact_bloc/constant.dart';
import 'package:contact_bloc/widget/contact_layout.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.contact});

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
              "no all contacts",
              style: textStyle30,
            ),
          );
  }
}
