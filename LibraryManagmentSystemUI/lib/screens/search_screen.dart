import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/components/three_cells_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item_details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  String filter = 'name';
  List<String> _filters = [
    'name',
    'type',
    'language',
    'author',
    'genre',
    'ISBN'
  ];
  TextEditingController _query = TextEditingController();

  Widget build(BuildContext context) {
    final _itemProvider = Provider.of<Item>(context);
    final _libraryProvider = Provider.of<Library>(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 20,
              color: Colors.white,
            ),
            TextField(
              onSubmitted: (val) {
                setState(() {});
              },
              textInputAction: TextInputAction.search,
              controller: _query,
              decoration: InputDecoration(
                prefixIcon: InkWell(
                  child: Icon(
                    Icons.arrow_back,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(15),
                filled: true,
                suffixIcon: InkWell(
                    onTap: () {
                      _query.clear();
                    },
                    child: Icon(Icons.clear)),
                hintText: '  Search Here',
              ),
            ),
            Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2.5),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(2.5),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(2.5),
                6: FlexColumnWidth(1),
              },
              // border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  Radio(
                    onChanged: (String val) {
                      setState(() {
                        filter = val;
                      });
                    },
                    value: 'name',
                    groupValue: filter,
                  ),
                  Text(
                    'Name',
                    textAlign: TextAlign.start,
                  ),
                  Radio(
                    onChanged: (String val) {
                      setState(() {
                        filter = val;
                      });
                    },
                    value: 'type',
                    groupValue: filter,
                  ),
                  Text('Type', textAlign: TextAlign.start),
                  Radio(
                    onChanged: (String val) {
                      setState(() {
                        filter = val;
                      });
                    },
                    value: 'genre',
                    groupValue: filter,
                  ),
                  Text('Genre', textAlign: TextAlign.start),
                ]),
                TableRow(children: [
                  Radio(
                    onChanged: (String val) {
                      setState(() {
                        filter = val;
                      });
                    },
                    value: 'ISBN',
                    groupValue: filter,
                  ),
                  Text('ISBN', textAlign: TextAlign.start),
                  Radio(
                    onChanged: (String val) {
                      setState(() {
                        filter = val;
                      });
                    },
                    value: 'author',
                    groupValue: filter,
                  ),
                  Text('Author', textAlign: TextAlign.start),
                  Radio(
                    onChanged: (String val) {
                      setState(() {
                        filter = val;
                      });
                    },
                    value: 'language',
                    groupValue: filter,
                  ),
                  Text('Language', textAlign: TextAlign.start),
                ]),
              ],
            ),
            Divider(),
            Container(
              child: FutureBuilder(
                future: _libraryProvider.search(by: filter, filter: _query.text),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return loading();
                  else if (snapshot.connectionState == ConnectionState.done) {
                    if (!snapshot.hasData) {
                      return Text(
                          _query.text.length == 0 ? '' : 'No Data Found!!');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          ItemSerializer item = snapshot.data[index];
                          return snapshot.data.length == 0
                              ? Text('No Data Found!!')
                              : Card(
                                  margin: EdgeInsets.only(
                                      bottom: 8, left: 8, right: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemInfoScreen(
                                                        libraryId:
                                                            item.libraryId,
                                                        itemId: item.id,
                                                      )));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    child: itemImage(
                                                        image: item.image),
                                                  ),
                                                  SizedBox(width: 13),
                                                  Expanded(
                                                    child: Table(
                                                      children: [
                                                        TableRow(children: [
                                                          Text('Library name',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .grey)),
                                                          Text('Type',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .grey))
                                                        ]),
                                                        TableRow(children: [
                                                          Text(
                                                            _libraryProvider
                                                                .libraries
                                                                .firstWhere((lib) =>
                                                                    lib.id ==
                                                                    item.libraryId)
                                                                .name,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          Text(
                                                            item.type,
                                                            textAlign: TextAlign
                                                                .center,
                                                          )
                                                        ])
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Table(
                                                children: [
                                                  threeRowsTitle(
                                                      context: context,
                                                      firstLabel: '',
                                                      secondLabel: 'Author',
                                                      thirdLabel: ''),
                                                  threeEmptyRows(5),
                                                  threeRows(
                                                      firstLabel: '',
                                                      secondLabel: item.author,
                                                      thirdLabel: ''),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Table(
                                                children: [
                                                  threeRowsTitle(
                                                      context: context,
                                                      firstLabel: 'Item name',
                                                      secondLabel: 'Late fees',
                                                      thirdLabel: 'Status'),
                                                  threeEmptyRows(5),
                                                  threeRows(
                                                      firstLabel: item.name,
                                                      secondLabel:
                                                          "\$${item.lateFees   }/day",
                                                      thirdLabel:
                                                          item.amount == 0
                                                              ? 'Not available'
                                                              : 'Available'),
                                                  threeEmptyRows(5),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                        },
                      );
                    }
                  } else {
                    return Text('');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
