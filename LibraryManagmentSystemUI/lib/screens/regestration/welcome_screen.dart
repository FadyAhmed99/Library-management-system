import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:LibraryManagmentSystem/classes/favorite.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:LibraryManagmentSystem/config.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:LibraryManagmentSystem/screens/library/libraries_room_screen.dart';
import 'package:LibraryManagmentSystem/screens/regestration/signin.dart';
import 'package:LibraryManagmentSystem/screens/regestration/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _init = true;
  bool _loading = true;
  @override
  void didChangeDependencies() async {
    if (_init) {
      final _userProvider = Provider.of<User>(context);
      final _transactionProvider = Provider.of<Transaction>(context);
      final _favProvider = Provider.of<Favorite>(context);
      final _borrowRequestProvider = Provider.of<BorrowRequest>(context);

      Future<void> userData() async {
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

      SharedPreferences _prefs = await SharedPreferences.getInstance();

      // login with old token if valid
      globalToken = _prefs.getString('token');
      await _userProvider.getProfile().then((err) async {
        if (err != null) {
          setState(() {
            _loading = false;
          });
        } else {
          await userData();
        }
      });

      // if facebook true
      if (_prefs.getBool('facebook') ?? false) {
        _userProvider.facebookLogin.currentAccessToken.then((value) {
          if (value != null && value.isValid()) {
            _userProvider.logInByFacebook(value.token).then((_) {
              userData().then((_) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => LibrariesRoomScreen()),
                    (Route<dynamic> route) => false);
              });
            });
          } else {
            setState(() {
              _loading = false;
            });
          }
        });
      }
      // else show form
      _init = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return ourDialog(
            context: context,
            error: 'Do you want to exit?',
            btn1: 'No',
            button2: FlatButton(
                child: Text('Exit'),
                onPressed: () => SystemChannels.platform
                    .invokeMethod('SystemNavigator.pop')));
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 15),
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    kLogo,
                    height: 100,
                    // width: 250,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Text(
                    'Librica',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey[900],
                    ),
                  ),
                ),
              ],
            ),
            _loading
                ? loading()
                // register buttons
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RoundedButton(
                          title: 'Log In',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        RoundedButton(
                          title: 'Register',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUp()));
                          },
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
