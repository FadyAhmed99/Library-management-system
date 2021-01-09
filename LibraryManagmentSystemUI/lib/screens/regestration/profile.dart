import 'dart:io';

import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/rounded_card.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class Profile extends StatefulWidget {
  final bool edit;
  Profile({@required this.edit});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _loading = false;
  bool _buttonLoading = false;
  bool _init = true;
  TextEditingController _fName = TextEditingController();
  TextEditingController _lName = TextEditingController();
  TextEditingController _num = TextEditingController();
  TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _photoLoading = false;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _user = Provider.of<User>(context).user;

      _fName.text = _user.firstname;
      _lName.text = _user.lastname;
      _num.text = _user.phoneNumber;
      _email.text = _user.email;
    }
    _init = false;
    super.didChangeDependencies();
  }

  final picker = ImagePicker();
  File _image;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<User>(context);
    UserSerializer _user = _userProvider.user;

    return Scaffold(
      appBar: appBar(
          backTheme: true,
          context: context,
          title: widget.edit ? 'Edit Profile' : 'Profile'),
      body: RefreshIndicator(
        onRefresh: () async {
          await _userProvider.getProfile();
          print(_user.profilePhoto);
        },
        child: ListView(children: [
          SizedBox(height: 16),
          Stack(
            children: [
              Center(
                child: Container(
                  child: CircleAvatar(
                      radius: 82,
                      backgroundColor: Colors.blue,
                      child: ClipOval(
                        child: CircleAvatar(
                          radius: 80,
                          child: _photoLoading
                              ? loading()
                              : FadeInImage(
                                  fit: BoxFit.fill,
                                  placeholder: kUserPlaceholder,
                                  image: NetworkImage(_user.profilePhoto ?? ''),
                                ),
                        ),
                      )),
                ),
              ),
              widget.edit
                  ? Container()
                  : Positioned(
                      bottom: 1,
                      right: 50,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Profile(edit: true)),
                          );
                        },
                        child: _loading
                            ? loading()
                            : FaIcon(FontAwesomeIcons.pen, color: Colors.blue),
                      ),
                    ),
              !widget.edit
                  ? Container()
                  : Positioned(
                      bottom: 1,
                      right: MediaQuery.of(context).size.width / 4,
                      left: MediaQuery.of(context).size.width / 2,
                      child: FloatingActionButton(
                        mini: true,
                        tooltip: 'Pick Image',
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _photoLoading = true;
                          });
                          getImage().then((value) {
                            if (_image == null) {
                              setState(() {
                                _photoLoading = false;
                              });
                            }

                            _userProvider
                                .changeProfileImage(image: _image.path)
                                .then((value) {
                              setState(() {
                                _photoLoading = false;
                              });
                            });
                          });
                        },
                      ),
                    ),
            ],
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              _user.username,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          widget.edit
              ? Container()
              : RoundedCard(
                  data: _user.firstname,
                  label: 'First name',
                  edit: widget.edit,
                  controller: _fName),
          widget.edit
              ? Container()
              : RoundedCard(
                  data: _user.lastname,
                  label: 'Last name',
                  edit: widget.edit,
                  controller: _lName),
          widget.edit
              ? Container()
              : RoundedCard(
                  data: _user.phoneNumber,
                  label: 'Phone number',
                  edit: widget.edit,
                  controller: _num),
          widget.edit
              ? Container()
              : RoundedCard(
                  data: _user.email,
                  label: 'Email',
                  edit: widget.edit,
                  controller: _email),
          widget.edit
              ? Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      RoundedCard(
                        data: _user.firstname,
                        label: 'First name',
                        edit: widget.edit,
                        controller: _fName,
                        validator: (String s) => s.length == 0 ? 'Empty' : null,
                      ),
                      RoundedCard(
                        data: _user.lastname,
                        label: 'Last name',
                        edit: widget.edit,
                        controller: _lName,
                        validator: (String s) => s.length == 0 ? 'Empty' : null,
                      ),
                      RoundedCard(
                        data: _user.phoneNumber,
                        label: 'Phone number',
                        edit: widget.edit,
                        controller: _num,
                        validator: (String s) => s.length == 0
                            ? null
                            : double.parse(s, (e) => null) == null
                                ? 'Not A Number!'
                                : (s.startsWith('01') && s.length == 11)
                                    ? null
                                    : 'Invalid Number',
                      ),
                      RoundedCard(
                        data: _user.email,
                        label: 'Email',
                        edit: widget.edit,
                        controller: _email,
                        validator: (String s) => s.length == 0 ? 'Empty' : null,
                      ),
                    ],
                  ),
                )
              : Container(),
          SizedBox(height: 15),
          widget.edit
              ? _buttonLoading
                  ? loading()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: RoundedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _buttonLoading = true;
                            });
                            _userProvider
                                .editProfile(
                                    firstname: _fName.text,
                                    email: _email.text,
                                    lastanme: _lName.text,
                                    phoneNum:
                                        _num.text.length == 0 ? ' ' : _num.text)
                                .then((err) async {
                              // TODO: snackBar
                              if (err == null) {
                                await _userProvider.getProfile().then((value) {
                                  setState(() {
                                    _fName.text = _user.firstname;
                                    _lName.text = _user.lastname;
                                    _buttonLoading = false;
                                  });
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Profile(
                                        edit: false,
                                      ),
                                    ),
                                  );
                                });
                              }
                            });
                          }
                        },
                        title: 'Edit',
                      ),
                    )
              : Container(),
          SizedBox(height: 25)
        ]),
      ),
    );
  }
}
