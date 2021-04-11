import 'package:flutter/material.dart';
import '../../screens/products/detail_product_screen.dart';

class BuildProdMarque extends StatefulWidget {
  BuildProdMarque(this.prod, this.prodDoc);
  final prod;
  final prodDoc;
  @override
  _BuildProdMarqueState createState() => _BuildProdMarqueState();
}

class _BuildProdMarqueState extends State<BuildProdMarque> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Stack(
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
                width: MediaQuery.of(context).size.width * 0.9,
                height: 300,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.purple,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.prod['imageUrl']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 7,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              margin: EdgeInsets.all(15.5),
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
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
