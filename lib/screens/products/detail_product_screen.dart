import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart.dart';

class DetailProduct extends StatefulWidget {
  final prod;
  final prodDoc;
  DetailProduct(this.prod, this.prodDoc);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  int _quant = 1;

  void _quantDelete() {
    if (_quant == 1) {
      setState(() {
        _quant = 1;
      });
    }
    if (_quant > 1) {
      setState(() {
        _quant--;
      });
    }
  }

  void _quantAdd() {
    if (_quant >= 10) {
      setState(() {
        _quant = 10;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Maximum'),
          content: Text('You can buy juste 10 quantity '),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            )
          ],
        ),
      );
    } else {
      setState(() {
        _quant++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(
          '${widget.prod['title']}',
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: widget.prod['imageUrl'],
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.prod['imageUrl']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                widget.prod['title'],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 3,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Price:  ${widget.prod['price']}" + "\DA",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                      color: Colors.purple,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: _quantDelete,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        Text(
                          '${_quant.toString()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: _quantAdd,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.prod['categorie'] != 'empty categorie')
              Container(
                padding:
                    const EdgeInsets.only(bottom: 4.0, left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: const Text(
                        'Categories',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.prod['categorie'],
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.purple,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.prod['marque'] != 'empty marque')
              Container(
                padding:
                    const EdgeInsets.only(bottom: 4.0, left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: const Text(
                        'Marque',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.prod['marque'],
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.purple,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: const Text(
                'Description',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Text(
                '${widget.prod['description']}',
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<Cart>(context, listen: false).addItem(
                  widget.prod['id'],
                  widget.prod['price'].toDouble(),
                  _quant,
                  widget.prod['title'],
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added item to cart!',
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        Provider.of<Cart>(context, listen: false)
                            .removeSingleItem(widget.prod['id']);
                      },
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    const Text(
                      'Add Cart',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
