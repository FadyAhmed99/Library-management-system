import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/classes/feedback.dart' as feed;
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendFeedbackScreen extends StatefulWidget {
  final LibrarySerializer library;

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
    final _libraryProvider = Provider.of<Library>(context);
    final _feedbackProvider = Provider.of<feed.Feedback>(context);

    return Scaffold(
      appBar: appBar(backTheme: false, context: context, title: 'Add Feedback'),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                      child: Text("Library Name:      ${widget.library.name}")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: myTextFormField(
                      context: context,
                      hint: 'Write feedback here',
                      label: 'Feedback',
                      validator: (text) {
                        if (text.length == 0) return 'Empty feedback';
                      },
                      controller: _text),
                ),
                _loading
                    ? loading()
                    : RoundedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            FocusScope.of(context).unfocus();
                            _feedbackProvider
                                .sendFeedback(
                                    libraryId: widget.library.id,
                                    feedback: _text.text)
                                .then((value) async {
                              if (value != null) {
                                ourDialog(context: context, error: value);
                              } else {
                                // TODO: Add snackbar
                                await _feedbackProvider.getLibraryFeedbacks(
                                    libraryId: widget.library.id);
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
      ),
    );
  }
}
