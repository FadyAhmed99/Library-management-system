import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/components/three_cells_row.dart';
import 'package:LibraryManagmentSystem/screens/item_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataSearch extends SearchDelegate<String> {
  final sugg = [];
  DataSearch({
    String hintText,
  }) : super(
          searchFieldLabel: 'Search items',
        );

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          //close(context, null);
          Navigator.of(context).pop();
        });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  var suggList;
  @override
  Widget buildSuggestions(BuildContext context) {
    final _libraryProvider = Provider.of<Library>(context);
    String filter = '';
    return Column(
      children: [
        Radio(
          onChanged: (String val) {
            filter = val;
          },
          value: 'name',
          groupValue: filter,
        ),
        Radio(
          onChanged: (String val) {
            filter = val;
          },
          value: 'type',
          groupValue: filter,
        ),
        Expanded(
          child: FutureBuilder(
            future: _libraryProvider.search(by: 'name', filter: query),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return loading();
              else if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Text('No Data Found!!');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      ItemSerializer item = snapshot.data[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ItemInfoScreen(
                                          libraryId: item.libraryId,
                                          itemId: item.id,
                                        )));
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 90,
                                          child: itemImage(image: item.image),
                                        ),
                                        SizedBox(width: 13),
                                        Expanded(
                                          child: Table(
                                            children: [
                                              TableRow(children: [
                                                Text('Library name',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .copyWith(
                                                            color:
                                                                Colors.grey)),
                                                Text('Type',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .copyWith(
                                                            color: Colors.grey))
                                              ]),
                                              TableRow(children: [
                                                Text(
                                                  '\\lib hc',
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  item.type,
                                                  textAlign: TextAlign.center,
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
                                            thirdLabel: item.amount == 0
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
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.length == 0
        ? Center(child: Text('...'))
        : Center(child: Text('غير موجود'));
  }

  @override
  void showResults(BuildContext context) {
    query = suggList[0];
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => null));
  }

  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1)}";
  }
}
