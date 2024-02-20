import 'package:contact_bloc/model/user_model.dart';
import 'package:contact_bloc/widget/tile_slider.dart';
import 'package:flutter/material.dart';

class ContactLayout extends StatelessWidget {
  const ContactLayout({super.key, required this.contact});

  final UserModel contact;

  @override
  Widget build(BuildContext context) {
    return TileSlider(
      widget: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(contact.avatar),
        ),
        title: Row(
          //here makes it according if it's 1 which means that it is fav
          children: [
            Text(contact.firstname),
            contact.favorite == 0
                ? Container()
                : const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
          ],
        ),
        subtitle: Text(contact.email),
        trailing: IconButton(
          onPressed: () {
            //ni go to profile page
            Navigator.of(context).pushNamed(
              '/profile',
              arguments: {
                'contact': contact,
                'from': 'profile',
              },
            );
          },
          icon: const Icon(
            Icons.send,
            color: Color(0xFF32BAA5),
          ),
        ),
      ),
      contact: contact,
    );
  }
}
