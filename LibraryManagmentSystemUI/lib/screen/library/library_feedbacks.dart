import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/model/feedback.dart' as feed;
import 'package:LibraryManagmentSystem/model/library.dart';
import 'package:LibraryManagmentSystem/provider/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedBackList extends StatefulWidget {
  final Library library;

  const FeedBackList({this.library});

  @override
  _FeedBackListState createState() => _FeedBackListState();
}

class _FeedBackListState extends State<FeedBackList> {
  bool _init = true;
  bool _loading = true;
  List<feed.Feedback> _feedbacks;
  @override
  void didChangeDependencies() {
    final _libraryProvider = Provider.of<LibraryProvider>(context);
    if (_init) {
      _libraryProvider.getFeedbacks(libraryId: widget.library.id).then((_) {
        _feedbacks = _libraryProvider.feedbacks;
        setState(() {
          _init = false;
          _loading = false;
        });
      });
      super.didChangeDependencies();
    }
    setState(() {
      _init = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ListTile(
            leading: userImage(image: _feedbacks[index].profilePhoto),
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
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Unknown',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
            ),
            contentPadding: EdgeInsets.all(8),
            subtitle: Text(_feedbacks[index].feedback,
                style: Theme.of(context).textTheme.bodyText1),
            tileColor: Colors.white),
      );
    }, childCount: _feedbacks.length));
  }
}
