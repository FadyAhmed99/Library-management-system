import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:LibraryManagmentSystem/classes/favorite.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:LibraryManagmentSystem/constants.dart';
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
  bool _bigLoading = false;

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<User>(context);
    final _transactionProvider = Provider.of<Transaction>(context);
    final _borrowRequestProvider = Provider.of<BorrowRequest>(context);

    final _favProvider = Provider.of<Favorite>(context);

    Function logInUser() {
      setState(() {
        _bigLoading = true;
      });
      _userProvider
          .logIn(_textEditingController1.text, _textEditingController2.text)
          .then((err) {
        if (err != null) {
          setState(() {
            _bigLoading = false;
          });
          ourDialog(context: context, error: err);
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
            ourDialog(context: context, error: response);
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
                        (Route<dynamic> route)  => false);
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
              child: ListView(
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      kLogo,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: myTextFormField(
                                      controller: _textEditingController1,
                                      hint: "Enter user name",
                                      label: "user name"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: myTextFormField(
                                    context: context,
                                    hint: "Enter password",
                                    label: "passowrd",
                                    obsecure: true,
                                    controller: _textEditingController2,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RoundedButton(
                              onPressed: logInUser,
                              title: 'Log in',
                            ),
                          ),
                          Center(child: Text('OR')),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RoundedButton(
                              onPressed: logInFacebook,
                              title: "Log in using facebook",
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
