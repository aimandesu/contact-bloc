import 'package:contact_bloc/bloc_pattern/bloc/contact/contact_bloc.dart';
import 'package:contact_bloc/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constant.dart';

class PictureName extends StatelessWidget {
  const PictureName({
    super.key,
    required this.contact,
    required this.editProfile,
    required this.changeEditProfile,
    required this.markFavourite,
  });

  final UserModel contact;
  final bool editProfile;
  final VoidCallback changeEditProfile;
  final void Function(UserModel) markFavourite;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: 250,
      width: size.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          editProfile
              ? Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 50,
                    child: IconButton(
                      onPressed: () async {
                        bool didUserClickYes =
                            await popDialog(context, contact.id);
                        if (didUserClickYes) {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Spacer(),
                      BlocSelector<ContactBloc, ContactState, int>(
                        selector: (state) {
                          if (state is ContactRefreshed) {
                            return state.user.favorite;
                          } else {
                            return contact.favorite;
                          }
                        },
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              int favUpdate = state == 0 ? 1 : 0;
                              UserModel updateContact = UserModel(
                                id: contact.id,
                                email: contact.email,
                                firstname: contact.firstname,
                                lastname: contact.lastname,
                                avatar: contact.avatar,
                                favorite: favUpdate,
                              );

                              markFavourite(updateContact);
                            },
                            icon: state == 0
                                ? const Icon(
                                    Icons.star_border,
                                  )
                                : const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                          );
                        },
                      ),
                      TextButton(
                        onPressed: changeEditProfile,
                        child: const Text("Edit"),
                      ),
                    ],
                  ),
                ),
          CircleAvatar(
            radius: 70,
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8), // Border radius
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  ClipOval(
                    child: Image.network(contact.avatar),
                  ),
                  editProfile
                      ? Positioned(
                          height: 20,
                          width: 20,
                          right: 10,
                          bottom: 0,
                          child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              )),
                        )
                      : BlocSelector<ContactBloc, ContactState, int>(
                          selector: (state) {
                            if (state is ContactRefreshed) {
                              return state.user.favorite;
                            } else {
                              return contact.favorite;
                            }
                          },
                          builder: (context, state) {
                            return state == 0
                                ? Container()
                                : const Positioned(
                                    height: 20,
                                    width: 20,
                                    right: 10,
                                    bottom: 10,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                  );
                          },
                        )
                ],
              ),
            ),
          ),
          Text("${contact.firstname} ${contact.lastname}"),
        ],
      ),
    );
  }
}
