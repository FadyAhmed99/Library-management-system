import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/model/library.dart';
import 'package:LibraryManagmentSystem/model/user.dart';
import 'package:LibraryManagmentSystem/provider/library_provider.dart';
import 'package:LibraryManagmentSystem/screen/library/library_feedbacks.dart';
import 'package:LibraryManagmentSystem/screen/library/send_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryInfoScreen extends StatefulWidget {
  final Library library;
  const LibraryInfoScreen({this.library});

  @override
  _LibraryInfoScreenState createState() => _LibraryInfoScreenState();
}

class _LibraryInfoScreenState extends State<LibraryInfoScreen> {
  bool _init = true;
  bool _loading = true;
  User _librarian;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<LibraryProvider>(context);

      _libraryProvider.getLibrarian(libraryId: widget.library.id).then((_) {
        _librarian = _libraryProvider.librarian;

        setState(() {
          _init = false;
          _loading = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                    tag: widget.library.id,
                    child:
                        Image.network(widget.library.image, fit: BoxFit.cover),
                  ),
                ),
                expandedHeight: 200,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: RoundedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SendFeedbackScreen(
                                    library: widget.library)));
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
                          _row('Library Name', widget.library.name),
                          _emptyRow(),
                          _row('Address', widget.library.address),
                          _emptyRow(),
                          _row('Phone Number', widget.library.phoneNumber),
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
