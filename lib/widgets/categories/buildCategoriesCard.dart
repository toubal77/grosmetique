import 'package:flutter/material.dart';
import 'package:grosmetique/widgets/categories/buildProductCategorie.dart';

class BuildCategoriesCard extends StatefulWidget {
  final cat;
  BuildCategoriesCard(this.cat);

  @override
  _BuildCategoriesCardState createState() => _BuildCategoriesCardState();
}

class _BuildCategoriesCardState extends State<BuildCategoriesCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(BuildProductCategorie.routeName,
                arguments: widget.cat['title']);
          },
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20.0),
                height: 280,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.cat['imageUrl'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 9,
                child: Container(
                  width: 230,
                  padding: EdgeInsets.only(right: 5.0, left: 15.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.cat['title'],
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
        ),
      ],
    );
  }
}
