import 'package:expensify/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TransactionListItems extends StatefulWidget {
  final Transaction trx;
  final Function dltTrxItem;

  const TransactionListItems({
    Key key,
    @required this.trx,
    @required this.dltTrxItem,
  }) : super(key: key);
  @override
  _TransactionListItemsState createState() => _TransactionListItemsState();
}

class _TransactionListItemsState extends State<TransactionListItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.lightBlueAccent[100],
          child: Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/cardbg1.png",
                    ),
                    fit: BoxFit.cover),
                border: Border.all(
                  width: 3,
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 60,
                      color: Colors.white,
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                                "assets/cardicons/${widget.trx.category}.png"),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "${widget.trx.title}",
                        maxFontSize: 24,
                        minFontSize: 18,
                        style: TextStyle(
                          fontFamily: 'proximabold',
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${widget.trx.category}",
                        style: TextStyle(
                          fontFamily: 'proximabold',
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.delete,
                  //     color: Theme.of(context).errorColor,
                  //   ),
                  //   onPressed: () => showDialog(
                  //     context: context,
                  //     barrierDismissible: false,
                  //     builder: (context) => AlertDialog(
                  //       title: const Text('Are you sure'),
                  //       content: const Text(
                  //           'Do you really want to delete this transaction?'),
                  //       actions: [
                  //         FlatButton(
                  //             onPressed: () {
                  //               widget.dltTrxItem(widget.trx.id);
                  //               Navigator.pop(context);
                  //             },
                  //             child: Text(
                  //               'Yes',
                  //               style: TextStyle(
                  //                   fontSize: 20,
                  //                   color: Theme.of(context).primaryColor),
                  //             )),
                  //         FlatButton(
                  //             onPressed: () {
                  //               Navigator.pop(context);
                  //             },
                  //             child: const Text(
                  //               'No',
                  //               style: TextStyle(fontSize: 20),
                  //             ))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${widget.trx.amount}",
                        style: TextStyle(
                          fontFamily: 'proximabold',
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().format(widget.trx.date),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
