import 'package:contact_bloc/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bloc_pattern/bloc/contact/contact_bloc.dart';
import '../../../constant.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.hint,
    this.contact,
  });

  final String hint;
  final UserModel? contact;

  void launchEmailSubmission(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      // query: 'subject=Default Subject&body=Default body'
    );
    String url = params.toString();
    // if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    // } else {
    //   print('Could not launch $url');
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (hint == "Done") {
          // contactProvider.updateContact(contact!);
          context.read<ContactBloc>().add(UpdateContact(user: contact as UserModel));
          context.read<ContactBloc>().add(RenderContact());
          Navigator.of(context).pop();
        } else {
          launchEmailSubmission(contact!.email);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: size.width * 0.9,
        height: 60,
        decoration: decorationCircular(Theme.of(context).primaryColor, 35),
        child: Center(
          child: Text(
            hint,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
