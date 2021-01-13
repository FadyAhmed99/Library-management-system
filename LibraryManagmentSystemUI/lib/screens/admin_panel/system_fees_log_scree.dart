import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/fee_tile.dart';
import 'package:LibraryManagmentSystem/classes/fee.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemFeesScreen extends StatefulWidget {
  @override
  _SystemFeesScreenState createState() => _SystemFeesScreenState();
}

class _SystemFeesScreenState extends State<SystemFeesScreen> {
  bool _init = true;
  bool _loading = true;
  List<FeeSerializer> _allFees = [];

  @override
  void didChangeDependencies() {
    if (_init) {
      final _userProvider = Provider.of<User>(context);

      _userProvider.getSystemFees().then((_) {
        setState(() {
          _loading = false;
          _allFees = _userProvider.allFees;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<User>(context);

    return _loading
        ? loading()
        : RefreshIndicator(
            onRefresh: () async {
              await _userProvider.getSystemFees();
            },
            child: ListView.builder(
                itemCount: _allFees.length,
                itemBuilder: (context, index) {
                  return FeeTile(
                    fee: _allFees[index],
                    admin: true,
                  );
                }),
          );
  }
}
