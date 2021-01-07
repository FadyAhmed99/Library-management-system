import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/fee_tile.dart';
import 'package:LibraryManagmentSystem/classes/fee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFeesScreen extends StatefulWidget {
  @override
  _UserFeesScreenState createState() => _UserFeesScreenState();
}

class _UserFeesScreenState extends State<UserFeesScreen> {
  bool _init = true;
  bool _loading = true;
  List<FeeSerializer> _fees = [];
  @override
  void didChangeDependencies() {
    final _feesProvider = Provider.of<Fee>(context);

    if (_init) {
      _feesProvider.getFees().then((_) {
        setState(() {
          _loading = false;
          _fees = _feesProvider.fees;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _feesProvider = Provider.of<Fee>(context);

    return _loading
        ? loading()
        : RefreshIndicator(
            onRefresh: () async {
              await _feesProvider.getFees();
            },
            child: ListView.builder(
                itemCount: _fees.length,
                itemBuilder: (context, index) {
                  return FeeTile(fee: _fees[index], admin: false);
                }),
          );
  }
}
