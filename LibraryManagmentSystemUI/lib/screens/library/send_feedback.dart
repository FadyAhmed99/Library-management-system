import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/models/library.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendFeedbackScreen extends StatefulWidget {
  final Library library;

  const SendFeedbackScreen({this.library});

  @override
  _SendFeedbackScreenState createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  TextEditingController _text = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final _libraryProvider = Provider.of<LibraryProvider>(context);

    return Material(
      child: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myTextFormField(context, 'Write feedback here', 'Feedback',
                  (text) {
                if (text.length == 0) return 'Empty feedback';
              }, _text),
              _loading
                  ? loading()
                  : RoundedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          FocusScope.of(context).unfocus();
                          _libraryProvider
                              .sendFeedback(
                                  libraryId: widget.library.id,
                                  feedback: _text.text)
                              .then((value) {
                            if (value != null) {
                              ourDialog(context: context, error: value);
                            } else {
                              // TODO: Add snackbar
                              Navigator.pop(context);
                            }
                          });
                        } else {
                          setState(() {
                            _loading = false;
                          });
                        }
                      },
                      title: 'Send',
                    )
            ],
          ),
        ),
      ),
    );
  }
}
