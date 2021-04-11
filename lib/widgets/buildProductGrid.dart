import 'package:flutter/material.dart';
import 'package:grosmetique/screens/products/detail_product_screen.dart';

class BuildProductGrid extends StatefulWidget {
  final prod;
  final prodDoc;
  BuildProductGrid(this.prod, this.prodDoc);

  @override
  _BuildProductGridState createState() => _BuildProductGridState();
}

class _BuildProductGridState extends State<BuildProductGrid> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) {
                    return DetailProduct(widget.prod, widget.prodDoc);
                  }),
                );
              },
              child: Hero(
                tag: widget.prod['imageUrl'],
                child: Container(
                  margin: EdgeInsets.only(right: 20.0),
                  height: 280,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.prod['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 230,
                padding: EdgeInsets.only(right: 5.0, left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.prod['title'],
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      "\DA" + widget.prod['price'].toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
