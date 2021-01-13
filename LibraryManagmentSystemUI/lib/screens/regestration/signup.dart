import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/components/text_form_field_class.dart';
import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:LibraryManagmentSystem/classes/favorite.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:LibraryManagmentSystem/screens/library/libraries_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _confirmEmail = TextEditingController();
  TextEditingController _phoneNum = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool _bigLoading = false;
  @override
  Widget build(BuildContext context) {
    List<KFormField> _fields = [
      KFormField(
          controller: _firstName,
          hint: 'Enter first name',
          label: "First name*",
          validator: (text) {
            if (text.length == 0) return 'Empty Name';
          }),
      KFormField(
          controller: _lastName,
          hint: 'Enter Last Name',
          label: "Last Name*",
          validator: (text) {
            if (text.length == 0) return 'Empty Name';
          }),
      KFormField(
          controller: _userName,
          hint: 'Enter user name',
          label: "User Name*",
          validator: (text) {
            if (text.length == 0) return 'Empty Name';
          }),
      KFormField(
          textInputType: TextInputType.emailAddress,
          controller: _email,
          hint: 'Enter email',
          label: "Email*",
          validator: (text) => text.length == 0
              ? 'Empty Email'
              : text == _confirmEmail.text
                  ? null
                  : 'Emails not matching'),
      KFormField(
          controller: _confirmEmail,
          textInputType: TextInputType.emailAddress,
          hint: 'Confirm your email',
          label: "Email confirm*",
          validator: (text) => text.length == 0
              ? 'Empty Email'
              : text == _email.text
                  ? null
                  : 'Emails not matching'),
      KFormField(
        textInputType: TextInputType.number,
        controller: _phoneNum,
        hint: 'Enter your phone number',
        label: "Phone number",
        validator: (String s) => s.length == 0
            ? null
            : double.parse(s, (e) => null) == null
                ? 'Not A Number!'
                : (s.startsWith('01') && s.length == 11)
                    ? null
                    : 'Invalid Number',
      ),
      KFormField(
          controller: _password,
          obsecure: true,
          hint: 'Enter Password',
          label: "Password*",
          validator: (text) => text.length == 0
              ? 'Empty Password'
              : text == _confirmPassword.text
                  ? null
                  : 'Passwords not matching'),
      KFormField(
          controller: _confirmPassword,
          obsecure: true,
          hint: 'Confirm password',
          label: "Confirm Password*",
          validator: (text) => text.length == 0
              ? 'Empty Password'
              : text == _password.text
                  ? null
                  : 'Passwords not matching'),
    ];

    final _userProvider = Provider.of<User>(context);
    final _favProvider = Provider.of<Favorite>(context);
    final _transactionProvider = Provider.of<Transaction>(context);
    final _borrowRequestProvider = Provider.of<BorrowRequest>(context);

    Function logInFacebook() {
      setState(() {
        _bigLoading = true;
      });
      _userProvider.signInByFacebook().then((response) {
        if (response != null) {
          {
            setState(() {
              _bigLoading = false;
            });
            return ourDialog(context: context, error: response);
          }
        } else {
          _userProvider.getProfile().then((_) {
            _borrowRequestProvider.getUserBorrowRequests().then((_) {
              _transactionProvider.getUserBorrowings().then((_) {
                _userProvider.getSubscribedLibraries().then((_) {
                  _favProvider.getFavourites().then((_) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => LibrariesRoomScreen()),
                        (Route<dynamic> route) => false);
                  });
                });
              });
            });
          });
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
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: Image.asset(
                            kLogo,
                            height: 250,
                            //width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                children: _fields.map((e) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: myTextFormField(
                                    context: context,
                                    controller: e.controller,
                                    hint: e.hint,
                                    label: e.label,
                                    obsecure: e.obsecure,
                                    validator: e.validator,
                                    textInputType: e.textInputType),
                              );
                            }).toList()),
                          ),
                        ),
                        _loading
                            ? loading()
                            : Center(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: RoundedButton(
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() {
                                              _bigLoading = true;
                                            });
                                            _userProvider
                                                .signUp(
                                              firstName: _firstName.text,
                                              lastName: _lastName.text,
                                              userName: _userName.text,
                                              email: _email.text,
                                              phoneNum: _phoneNum.text,
                                              password: _password.text,
                                            )
                                                .then((err) {
                                              if (err != null) {
                                                setState(() {
                                                  _bigLoading = false;
                                                });

                                                ourDialog(
                                                    context: context,
                                                    error: err);
                                              } else {
                                                _userProvider
                                                    .getProfile()
                                                    .then((_) {
                                                  _borrowRequestProvider
                                                      .getUserBorrowRequests()
                                                      .then((_) {
                                                    _transactionProvider
                                                        .getUserBorrowings()
                                                        .then((_) {
                                                      _userProvider
                                                          .getSubscribedLibraries()
                                                          .then((_) {
                                                        _favProvider
                                                            .getFavourites()
                                                            .then((_) {
                                                          Navigator.of(context)
                                                              .pushAndRemoveUntil(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              LibrariesRoomScreen()),
                                                                  (Route<dynamic>
                                                                          route) =>
                                                                      false);
                                                        });
                                                      });
                                                    });
                                                  });
                                                });
                                              }
                                            });
                                          }
                                        },
                                        title: 'Sign up',
                                      ),
                                    ),
                                    Center(child: Text('OR')),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: RoundedButton(
                                        onPressed: logInFacebook,
                                        title: "Sign up using facebook",
                                      ),
                                    )
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
