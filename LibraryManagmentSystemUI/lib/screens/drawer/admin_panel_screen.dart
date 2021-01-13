import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/screens/admin_panel/latest_addition.dart';
import 'package:LibraryManagmentSystem/screens/admin_panel/system_users_list_screen.dart';
import 'package:LibraryManagmentSystem/screens/admin_panel/system_users_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPanelScreen extends StatefulWidget {
  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

int lib1 = 0;
int lib2 = 0;
int lib3 = 0;

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  String lib = '';
  @override
  Widget build(BuildContext context) {
    final _libraryProvider = Provider.of<Library>(context);

    return Scaffold(
        appBar: appBar(
            backTheme: true, title: 'Statstical Report', context: context),
        body: Column(
          children: {
                'System\'s Uers Logs': SystemLogsScreen(),
                'System\'s Users List': SystemUsersList(),
                //'Latest Additions': LibraryLatestAddition(libraryNumber: 1,),
              }
                  .entries
                  .map((e) => Container(
                        margin: const EdgeInsets.all(16.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          tileColor: Theme.of(context).cardColor,
                          title: Center(child: Text(e.key)),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => e.value)),
                        ),
                      ))
                  .toList() +
              [
                Container(
                    margin: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(30),
                            isCollapsed: true,
                            border: InputBorder.none,
                          ),
                          hint: Text(
                            'Latest Additions',
                          ),
                          validator: (value) =>
                              value == null ? 'Empty Type' : null,
                          items: _libraryProvider.libraries
                              .map((e) {
                                return e;
                              })
                              .toList()
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name,
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  )))
                              .toList(),
                          onChanged: (LibrarySerializer val) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LibraryLatestAddition(
                                    libraryNumber: val.id),
                              ),
                            );
                          }),
                    ))
              ],
        ));
  }
}
