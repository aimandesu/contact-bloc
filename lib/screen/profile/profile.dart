import 'package:contact_bloc/bloc_pattern/bloc/contact/contact_bloc.dart';
import 'package:contact_bloc/bloc_pattern/cubit/update_profile/update_profile_cubit.dart';
import 'package:contact_bloc/screen/profile/widgets/email.dart';
import 'package:contact_bloc/screen/profile/widgets/picture_name.dart';
import 'package:contact_bloc/screen/profile/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user_model.dart';
import 'edit_fields/edit_fields.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
    required this.contact,
    required this.from,
  });

  final UserModel contact;
  final String from;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //text editing controller
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();

  //variables
  bool _isInit = true;
  bool _edit = false;

  void changeEditProfile() {
    _edit == false ? _edit = true : _edit = false;
    context.read<UpdateProfileCubit>().editProfile(_edit);
  }

  void markFavourite(UserModel user) async {
    context.read<ContactBloc>().add(UpdateContact(user: user));
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      firstName.text = widget.contact.firstname;
      lastName.text = widget.contact.lastname;
      email.text = widget.contact.email;

      if (widget.from == "edit") changeEditProfile();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        didPop ? context.read<ContactBloc>().add(RenderContact()) : null;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
            builder: (context, state) {
              if (state is UpdateProfileLoad) {
                return Column(
                  children: [
                    PictureName(
                      editProfile: state.isUpdateProfile,
                      contact: widget.contact,
                      changeEditProfile: changeEditProfile,
                      markFavourite: markFavourite,
                    ),
                    state.isUpdateProfile
                        ? SizedBox(
                            height: 400,
                            width: size.width * 0.9,
                            child: EditFields(
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              contact: widget.contact,
                              changeEditProfile: changeEditProfile,
                            ),
                          )
                        : Column(
                            children: [
                              Email(email: widget.contact.email),
                              SubmitButton(
                                hint: "Send Email",
                                contact: widget.contact,
                              )
                            ],
                          ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
