import 'package:contact_bloc/model/user_model.dart';
import 'package:flutter/material.dart';
import '../widgets/submit_button.dart';

class EditFields extends StatelessWidget {
  const EditFields({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
    required this.changeEditProfile,
  });

  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final UserModel contact;
  final VoidCallback changeEditProfile;

  @override
  Widget build(BuildContext context) {
    final UserModel updatedContact = UserModel(
      id: contact.id,
      email: email.text,
      firstname: firstName.text,
      lastname: lastName.text,
      avatar: contact.avatar,
      favorite: contact.favorite,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        definedInput("First Name", context, firstName, TextInputType.text),
        definedInput("Last Name", context, lastName, TextInputType.text),
        definedInput("Email", context, email, TextInputType.text),
        SubmitButton(
          hint: "Done",
          contact: updatedContact,
        )
      ],
    );
  }

  Column definedInput(
    String hintText,
    BuildContext context,
    TextEditingController textEditingController,
    TextInputType textInputType,
  ) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                hintText,
                style: const TextStyle(color: Color(0xFF32BAA5)),
              ),
            )),
        Container(
          padding: const EdgeInsets.all(10),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: TextField(
            enableInteractiveSelection: false,
            controller: textEditingController,
            keyboardType: textInputType,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration.collapsed(
              hintText: '',
            ),
          ),
        ),
      ],
    );
  }
}
