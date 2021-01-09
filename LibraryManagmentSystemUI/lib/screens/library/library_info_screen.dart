import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/classes/feedback.dart' as feed;
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';

import 'package:LibraryManagmentSystem/screens/library/edit_library_info.dart';
import 'package:LibraryManagmentSystem/screens/library/send_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryInfoScreen extends StatefulWidget {
  final String libraryId;
  const LibraryInfoScreen({this.libraryId});

  @override
  _LibraryInfoScreenState createState() => _LibraryInfoScreenState();
}

class _LibraryInfoScreenState extends State<LibraryInfoScreen> {
  bool _init = true;
  bool _loading = true;
  UserSerializer _librarian;
  LibrarySerializer _library;
  List<feed.FeedbackSerializer> _feedbacks = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<Library>(context);
      final _feedbackProvider = Provider.of<feed.Feedback>(context);

      _libraryProvider.getLibraryInfo(libraryId: widget.libraryId).then((_) {
        setState(() {
          _librarian = _libraryProvider.librarian;
          _library = _libraryProvider.library;
          _init = false;
          _loading = false;
        });
      });
      _feedbackProvider
          .getLibraryFeedbacks(libraryId: widget.libraryId)
          .then((_) {
        _feedbacks = _feedbackProvider.feedbacks;
        setState(() {
          _init = false;
          _loading = false;
        });
      });
      super.didChangeDependencies();

      setState(() {
        _init = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context).user;
    final _libraryProvider = Provider.of<Library>(context);
    _library = _libraryProvider.library;
    final _feedbackProvider = Provider.of<feed.Feedback>(context);
    final _subsLibrariesProvider = Provider.of<User>(context);

    return _loading
        ? loading()
        : Scaffold(
            body: RefreshIndicator(
            onRefresh: () async {
              await _libraryProvider.getLibraryInfo(
                  libraryId: widget.libraryId);
              await _feedbackProvider.getLibraryFeedbacks(
                  libraryId: widget.libraryId);
            },
            child: Center(
              child: ListView(children: [
                Container(
                  child: libraryImage(image: _library.image, fit: BoxFit.cover),
                ),
                _libraryProvider.librarian.id == _user.id
                    ? Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RoundedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          EditLibraryInfoScreen(
                                              library: _library)));
                                },
                                title: 'Edit Info',
                              ),
                            ),
                          ),
                        ],
                      )
                    : !_user.librarian
                        ? Row(
                            children: [
                              _subsLibrariesProvider.subs
                                          .where((sub) =>
                                              sub.status == 'member' &&
                                              sub.id == widget.libraryId)
                                          .toList()
                                          .length ==
                                      0
                                  ? Container()
                                  : Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        child: RoundedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SendFeedbackScreen(
                                                            library:
                                                                _library)));
                                          },
                                          title: 'Add Feedback',
                                        ),
                                      ),
                                    ),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: SmallButton(
                                      onPressed: () async {
                                        String toMailId = _librarian.email;
                                        const subject = 'About Your Library';
                                        const body = '';
                                        var url =
                                            'mailto:$toMailId?subject=$subject&body=$body';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Icon(Icons.mail),
                                    ),
                                  )),
                            ],
                          )
                        : Padding(padding: EdgeInsets.all(0)),

                // info
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  child: Table(
                      // border: TableBorder.all(),
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      textDirection: TextDirection.ltr,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        _emptyRow(),
                        _row('Library Name', _library.name),
                        _emptyRow(),
                        _row('Description', _library.description),
                        _emptyRow(),
                        _row('Address', _library.address),
                        _emptyRow(),
                        _row('Phone Number',
                            _libraryProvider.library.phoneNumber),
                        _emptyRow(),
                        _row(
                            'Librarian\'s Name',
                            _libraryProvider.librarian.firstname +
                                ' ' +
                                _libraryProvider.librarian.lastname),
                        _emptyRow(),
                        _row('Librarian\'s Email',
                            _libraryProvider.librarian.email),
                        _emptyRow(),
                      ]),
                ),

                // feedback
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Feedbacks:',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Container(
                  child: ListView.builder(
                    itemCount: _feedbacks.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: ListTile(
                            leading: userImage(
                                image: _feedbacks[index].profilePhoto),
                            isThreeLine: true,
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: _feedbacks[index].firstname.length != 0 ||
                                      _feedbacks[index].lastname.length != 0
                                  ? Text(
                                      _feedbacks[index].firstname +
                                          ' ' +
                                          _feedbacks[index].lastname,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      'Unknown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            subtitle: Text(_feedbacks[index].feedback,
                                style: Theme.of(context).textTheme.bodyText1),
                            tileColor: Colors.white),
                      );
                    },
                  ),
                )
              ]),
            ),
          ));
  }

  TableRow _row(String label, String data) {
    return TableRow(children: [
      Text(
        label + ': ',
        // textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(fontWeight: FontWeight.normal),
      ),
      Text(
        data,
        // textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2,
      )
      //.copyWith(color: Colors.black, fontWeight: FontWeight.normal)),
    ]);
  }

  TableRow _emptyRow() {
    return TableRow(children: [
      Container(height: 25),
      Container(height: 25),
    ]);
  }
}
