import 'package:flutter/material.dart';
import 'package:hello_world/models/Transaction.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteItem;
  TransactionList(this.transactions, this.deleteItem);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Container(
            child: transactions.isEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No Transactions yet!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: constrains.maxHeight * 0.6,
                        child: Image.asset('assets/images/waiting.png'),
                      )
                    ],
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '\$${transactions[index].amount.toStringAsFixed(2)}',
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            '${transactions[index].title}',
                            style: TextStyle(
                                color: Theme.of(ctx).primaryColorLight),
                          ),
                          subtitle: Text(DateFormat.yMMM()
                              .format(transactions[index].date)),
                          trailing: MediaQuery.of(context).size.width > 400
                              ? TextButton.icon(
                                  label: Text('Delete'),
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      deleteItem(transactions[index].id))
                              : IconButton(
                                  color: Theme.of(context).errorColor,
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      deleteItem(transactions[index].id)),
                        ),
                      );
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         padding: EdgeInsets.all(5),
                      //         child: Text(
                      //           '\$${transactions[index].amount.toStringAsFixed(2)}',
                      //           style: TextStyle(
                      //               color: Theme.of(context).primaryColorLight,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 20),
                      //         ),
                      //         margin: EdgeInsets.symmetric(
                      //             horizontal: 10, vertical: 15),
                      //         decoration: BoxDecoration(
                      //             border: Border.all(
                      //           width: 2,
                      //           color: Theme.of(context).primaryColorDark,
                      //         )),
                      //       ),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Container(
                      //             padding: EdgeInsets.only(bottom: 6),
                      //             child: Text(
                      //               '${transactions[index].title}',
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 15,
                      //               ),
                      //             ),
                      //           ),
                      //           Container(
                      //               child: Text(
                      //                   DateFormat.yMMMMd()
                      //                       .format(transactions[index].date),
                      //                   style: TextStyle(
                      //                       fontSize: 10, color: Colors.grey))),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // );
                    }));
      },
    );
  }
}
