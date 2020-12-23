import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart';
import 'package:LibraryManagmentSystem/screens/library/libraries_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  bool _loading = false;
  bool _bigLoading = false;
  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);

    Function logInUser() {
      setState(() {
        _loading = true;
      });
      _userProvider
          .logInUser(_textEditingController1.text, _textEditingController2.text)
          .then((err) {
        if (err != null) {
          setState(() {
            _loading = false;
          });
          ourDialog(context: context, error: err);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LibrariesRoomScreen()),
              (Route<dynamic> route) => false);
        }
      });
    }

    Function logInFacebook() {
      setState(() {
        _bigLoading = true;
      });
      _userProvider.facebookSignin().then((response) {
        if (response != null) {
          {
            setState(() {
              _bigLoading = false;
            });
            return ourDialog(context: context, error: response);
          }
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LibrariesRoomScreen()),
              (Route<dynamic> route) => false);
        }
      });
    }

    return Scaffold(
      body: _bigLoading
          ? loading()
          : InkWell(
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
                          onPressed: logInUser,
                          title: 'Log in',
                        ),
                  SizedBox(height: 16),
                  Center(child: Text('OR')),
                  RoundedButton(
                    onPressed: logInFacebook,
                    title: "Log in using facebook",
                  )
                ],
              ),
            ),
    );
  }
}
