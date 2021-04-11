import 'package:flutter/material.dart';
import 'package:grosmetique/widgets/brands/buildProductMarque.dart';

class BuildBrandsCard extends StatelessWidget {
  final catProd;
  BuildBrandsCard(this.catProd);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(BuildProductMarque.routeName,
                arguments: catProd['title']);
          },
          child: Card(
            elevation: 1.2,
            child: Container(
              width: 150,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(catProd['imageUrl']),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
