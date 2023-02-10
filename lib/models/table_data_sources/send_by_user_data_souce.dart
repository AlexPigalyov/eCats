import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/wallets/wallet_request_model.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:flutter/material.dart';

class SendByUserDataSource extends DataTableSource {
  SendByUserDataSource.empty(this.context) {
    wallets = [];
  }

  SendByUserDataSource(this.context, this.wallets, this.screenCallback,
      [this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]);

  late void Function(PageModel?, bool, PageModel) screenCallback;
  final BuildContext context;
  late List<WalletRequestModel>? wallets;
  bool hasRowTaps = false;
  bool hasRowHeightOverrides = false;
  bool hasZebraStripes = false;

  void sort<T>(
      Comparable<T> Function(WalletRequestModel d) getField, bool ascending) {
    wallets?.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  DataRow getRow(int index, [Color? color]) {
    if (index >= wallets!.length) throw 'index > _walletsz.length';
    final wallet = wallets![index];
    return DataRow2.byIndex(
      index: index,
      selected: wallet.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      cells: [
        DataCell(Container(
          alignment: Alignment.centerLeft,
          child: Text(wallet.currencyAcronim!, textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(wallet.value.toString(), textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: TextButton(
            child: Text("Send ${wallet.currencyAcronim}"),
            onPressed: () async {
              screenCallback(
                  PageModel(
                      page: PageEnum.Send,
                      appBar: AppBarEnum.Authorized,
                      args: null),
                  true,
                  PageModel(
                      page: PageEnum.SendCoins,
                      appBar: AppBarEnum.Authorized,
                      args: wallet.currencyAcronim));
            },
          ),
        ))
      ],
    );
  }

  @override
  int get rowCount => wallets!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  int _selectedCount = 0;

  void selectAll(bool? checked) {
    for (final wallet in wallets!) {
      wallet.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? wallets!.length : 0;
    notifyListeners();
  }
}
