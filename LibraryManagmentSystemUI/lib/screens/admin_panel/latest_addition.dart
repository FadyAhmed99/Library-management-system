import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/components/three_cells_row.dart';
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/screens/item_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryLatestAddition extends StatefulWidget {
  final String libraryNumber;

  const LibraryLatestAddition({Key key, this.libraryNumber}) : super(key: key);
  @override
  _LibraryLatestAdditionState createState() => _LibraryLatestAdditionState();
}

class _LibraryLatestAdditionState extends State<LibraryLatestAddition> {
  bool _init = true;
  bool _loading = true;
  List<ItemSerializer> _items = [];
  Map<int, String> libs = {
    1: '5fd53f880f2d076ac295de1d',
    2: '5fd53f8e0f2d076ac295de1e',
    3: '5fd53f910f2d076ac295de1f',
  };
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<Library>(context);

      _libraryProvider
          .latestAddition(
              libs.keys.firstWhere((lib) => libs[lib] == widget.libraryNumber))
          .then((_) {
        setState(() {
          _loading = false;
          _items = _libraryProvider.items;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _libraryProvider = Provider.of<Library>(context);

    return Scaffold(
      appBar: appBar(
        backTheme: true,
        context: context,
        title:
            "Library ${libs.keys.firstWhere((lib) => libs[lib] == widget.libraryNumber).toString()} latest addition",
      ),
      body: _loading
          ? loading()
          : RefreshIndicator(
              onRefresh: () async {
                await _libraryProvider.latestAddition(libs.keys
                    .firstWhere((lib) => libs[lib] == widget.libraryNumber));
              },
              child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 130,
                                  height: 80,
                                  padding: EdgeInsets.all(8),
                                  child: itemImage(
                                      image: _items[index].image,
                                      fit: BoxFit.fill),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallButton(
                                      child: Text('View Details'),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ItemInfoScreen(
                                              itemId: _items[index].id,
                                              libraryId: widget.libraryNumber,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Table(
                              children: [
                                threeRowsTitle(
                                    context: context,
                                    firstLabel: 'Item Name',
                                    secondLabel: 'Shelf Number',
                                    thirdLabel: 'Status'),
                                threeRows(
                                    firstLabel: _items[index].name,
                                    secondLabel: _items[index].location,
                                    thirdLabel: _items[index].amount == 0
                                        ? 'Not Avaiable'
                                        : 'Avaiable')
                              ],
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
