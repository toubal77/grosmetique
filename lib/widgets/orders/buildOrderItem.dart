import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/products_data.dart';
import 'package:timeago/timeago.dart' as timeago;

class BuildOrderItem extends StatefulWidget {
  final order;
  BuildOrderItem(this.order);
  @override
  _BuildOrderItemState createState() => _BuildOrderItemState();
}

class _BuildOrderItemState extends State<BuildOrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _expanded
              ? widget.order['products'].length != 1
                  ? min(widget.order['products'].length * 40.0 + 130, 250)
                  : min(widget.order['products'].length * 40.0 + 140, 270)
              : 95,
          child: Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  child: ListTile(
                    title:
                        Text('\DA${widget.order['amount'].toStringAsFixed(2)}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(timeago
                            .format(DateTime.tryParse(
                                widget.order['dateTime'].toString()))
                            .toString()),
                        Text(
                          widget.order['confirmed']
                              ? 'Order confirmed'
                              : 'Order not confirmed yet',
                        ),
                      ],
                    ),
                    trailing: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.verified,
                            color: widget.order['confirmed']
                                ? Colors.green
                                : Colors.red,
                          ),
                          IconButton(
                            icon: Icon(_expanded
                                ? Icons.expand_less
                                : Icons.expand_more),
                            onPressed: () {
                              setState(() {
                                _expanded = !_expanded;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  height: _expanded
                      ? widget.order['products'].length != 1
                          ? min(Products().prods.length * 70.0 + 180, 118)
                          : min(Products().prods.length * 20.0 + 120, 85)
                      : 0,
                  child: ListView.builder(
                    itemCount: widget.order['products'].length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(
                                  widget.order['products'][index]['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${widget.order['products'][index]['quantity']}x \DA${widget.order['products'][index]['price']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
