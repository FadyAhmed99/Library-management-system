import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/models/library.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditLibraryInfoScreen extends StatefulWidget {
  final Library library;

  const EditLibraryInfoScreen({this.library});

  @override
  _EditLibraryInfoScreenState createState() => _EditLibraryInfoScreenState();
}

class _EditLibraryInfoScreenState extends State<EditLibraryInfoScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  @override
  void initState() {
    _name = TextEditingController(text: widget.library.name);
    _address = TextEditingController(text: widget.library.address);
    _desc = TextEditingController(text: widget.library.description);
    _phone = TextEditingController(text: widget.library.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<KFormField> fields = [
      KFormField(
          controller: _name,
          hint: 'Type Name Here',
          label: "Library Name",
          validator: (text) {
            if (text.length == 0) return 'Empty Name';
          }),
      KFormField(
          controller: _address,
          hint: 'Type Address Here',
          label: "Library Address",
          validator: (text) {
            if (text.length == 0) return 'Empty Address';
          }),
      KFormField(
          controller: _desc,
          hint: 'Type Description Here',
          label: "Description",
          validator: (text) {
            if (text.length == 0) return 'Empty Description';
          }),
      KFormField(
          controller: _phone,
          hint: 'Type Phone Number Here',
          label: "Library Phone Number",
          validator: (text) {
            if (text.length == 0) return 'Empty Phone Number';
          }),
    ];
    final _libraryProvider = Provider.of<LibraryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Library Info'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: ListView(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: fields.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: myTextFormField(context, e.hint, e.label,
                            e.validator, e.controller),
                      );
                    }).toList()),
                SizedBox(height: 20),
                _loading
                    ? loading()
                    : RoundedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              FocusScope.of(context).unfocus();
                              _loading = true;
                            });
                            _libraryProvider
                                .editLibraryInfo(
                                    libraryId: widget.library.id,
                                    address: _address.text,
                                    desc: _desc.text,
                                    name: _name.text,
                                    phoneNum: _phone.text)
                                .then((err) {
                              if (err != null)
                                ourDialog(context: context, error: err);
                              else {
                                // TODO: add snackbar
                                _libraryProvider
                                    .getLibrary(libraryId: widget.library.id)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              }
                            });
                          }
                        },
                        title: 'Submit',
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KFormField {
  String label;
  String hint;
  Function validator;
  TextEditingController controller;

  KFormField({this.label, this.hint, this.validator, this.controller});
}
