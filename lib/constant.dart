import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_pattern/bloc/contact/contact_bloc.dart';

SnackBar popSnackBar(String text) {
  return SnackBar(
    content: Text(text),
  );
}

TextStyle textStyle30 = const TextStyle(
  fontSize: 30,
);

Decoration decorationCircular(Color color, double circular) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(circular),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 2,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
  );
}

Future<bool> popDialog(
  BuildContext context,
  int value,
) async {
  bool userClickedYes = false;

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure you want to delete this contact?'),
        actions: <Widget>[
          const Divider(),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    context.read<ContactBloc>().add(DeleteContact(id: value));
                    if (context.mounted) {
                      userClickedYes = true;
                      Navigator.of(context).pop();
                    }
                  },
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                TextButton(
                  child: const Text(
                    'No',
                    style: TextStyle(color: Color(0xFF32BAA5)),
                  ),
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      );
    },
  );

  return userClickedYes;
}
