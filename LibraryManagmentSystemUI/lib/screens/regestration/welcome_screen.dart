import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart';
import 'package:LibraryManagmentSystem/screens/library/libraries_room_screen.dart';
import 'package:LibraryManagmentSystem/screens/regestration/signin.dart';
import 'package:LibraryManagmentSystem/screens/regestration/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _init = true;
  bool _loading = true;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _userProvider = Provider.of<UserProvider>(context);
      _userProvider.facebookLogin.currentAccessToken.then((value) {
        if (value != null && value.isValid()) {
          _userProvider.logInFacebookUser(value.token).then((_) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LibrariesRoomScreen()),
                (Route<dynamic> route) => false);
          });
        } else {
          setState(() {
            _loading = false;
          });
        }
        setState(() {
          _init = false;
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return ourDialog(
            context: context,
            error: 'Are You Sure Exit?',
            button2: FlatButton(
                child: Text('Exit'),
                onPressed: () => SystemChannels.platform
                    .invokeMethod('SystemNavigator.pop')));
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: [
                  Image.asset(
                    'assets/images/user.png',
                    height: 150,
                    width: 150,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Library',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Mangement',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'System',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              _loading
                  ? loading()
                  // register buttons
                  : Column(
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
                        RoundedButton(
                          title: 'Register',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUp()));
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
