import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/models/library.dart';
import 'package:LibraryManagmentSystem/models/user.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart';
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
  User _librarian;
  Library _library;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<LibraryProvider>(context);

      _libraryProvider.getLibrary(libraryId: widget.libraryId).then((_) {
        setState(() {
          _librarian = _libraryProvider.librarian;
          _library = _libraryProvider.library;
          _init = false;
          _loading = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context).user;
    final _libraryProvider = Provider.of<LibraryProvider>(context);
    _library = _libraryProvider.library;

    return _loading
        ? loading()
        : Scaffold(
            body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                leading: null,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: _library.id,
                    child: Image.network(_library.image, fit: BoxFit.cover),
                  ),
                ),
                expandedHeight: 200,
              ),
              _user.isLibrarian(_librarian.id)
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 2,
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
                          ],
                        );
                      }, childCount: 1),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: RoundedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SendFeedbackScreen(
                                          library: _library)));
                                },
                                title: 'Send Feedback',
                              ),
                            ),
                            Expanded(
                                flex: 1,
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
                                  icon: Icons.mail,
                                )),
                          ],
                        );
                      }, childCount: 1),
                    ),

              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.top,
                        textDirection: TextDirection.ltr,
                        children: [
                          _emptyRow(),
                          _row('Library Name', _library.name),
                          _emptyRow(),
                          _row('Address', _library.address),
                          _emptyRow(),
                          _row('Phone Number', _library.phoneNumber),
                          _emptyRow(),
                          _row('Librarian Name',
                              _librarian.firstname + _librarian.lastname),
                          _emptyRow(),
                          _row('Librarian Email', _librarian.email),
                          _emptyRow(),
                        ]),
                  );
                }, childCount: 1),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Feedbacks:',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  );
                }, childCount: 1),
              ),
              // ListView.builder(itemBuilder: (context, index) {
              //   return Text('data');
              // })
            ],
          ));
  }

  TableRow _row(String label, String data) {
    return TableRow(children: [
      Text(
        label + ': ',
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(fontWeight: FontWeight.normal),
      ),
      Text(data,
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Colors.black, fontWeight: FontWeight.normal)),
    ]);
  }

  TableRow _emptyRow() {
    return TableRow(children: [
      Container(height: 25),
      Container(height: 25),
    ]);
  }
}
