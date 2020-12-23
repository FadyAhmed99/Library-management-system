import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart';
import 'package:LibraryManagmentSystem/screens/library/libraries_room_screen.dart';
import 'package:LibraryManagmentSystem/screens/regestration/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Form(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  TextFormField(
                    decoration: myTextFieldDecoration(
                        context: context,
                        hint: "Enter user name",
                        label: "user name:"),
                    textAlign: TextAlign.center,
                    controller: _textEditingController1,
                  ),
                  TextFormField(
                    decoration: myTextFieldDecoration(
                        context: context,
                        hint: "Enter password",
                        label: "passowrd:"),
                    textAlign: TextAlign.center,
                    controller: _textEditingController2,
                  ),
                ]),
              ),
            ),
            _loading
                ? loading()
                : RoundedButton(
                    onPressed: () {
                      setState(() {
                        _loading = true;
                      });
                      userProvider
                          .signUpUser(_textEditingController1.text,
                              _textEditingController2.text)
                          .then((err) {
                        if (err != null) {
                          setState(() {
                            _loading = false;
                          });

                          ourDialog(context: context, error: err);
                        } else {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LibrariesRoomScreen()),
                              (Route<dynamic> route) => false);
                        }
                      });
                    },
                    title: 'Sign up',
                  )
          ],
        ),
      ),
    );
  }
}
