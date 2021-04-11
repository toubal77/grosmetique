import 'package:flutter/material.dart';
import '../../screens/products/detail_product_screen.dart';

class BuildProdCategorie extends StatefulWidget {
  BuildProdCategorie(this.prod, this.prodDoc);
  final prod;
  final prodDoc;

  @override
  _BuildProdCategorieState createState() => _BuildProdCategorieState();
}

class _BuildProdCategorieState extends State<BuildProdCategorie> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
            width: MediaQuery.of(context).size.width * 0.9,
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
    );
  }
}
