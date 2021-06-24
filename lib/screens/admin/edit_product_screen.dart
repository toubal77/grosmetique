import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/products_data.dart';

class EditProductScreen extends StatefulWidget {
  static final routeName = '/edit_product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final categoriesController = TextEditingController();
  final marquesController = TextEditingController();
  var productId;
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> _dropdownValueMar = [];
  List<DropdownMenuItem<String>> _dropdownValueCat = [];
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    categories: '',
    marques: '',
    imageUrl: '',
  );

  var _isInit = true;
  var _isLoading = false;
  var prodDoc;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void didChangeDependencies() async {
    if (_isInit) {
      productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        var snapshot =
            await FirebaseFirestore.instance.collection('products').get();
        var _products = snapshot.docs;
        var _prod =
            _products.firstWhere((prod) => prod.data()['id'] == productId);
        prodDoc = _prod.id;
        _titleController.text = _prod['title'];
        _priceController.text = _prod['price'].toString();
        _descriptionController.text = _prod['description'];
        _imageUrlController.text = _prod['imageUrl'];
        categoriesController.text = _prod['categorie'];
        marquesController.text = _prod['marque'];
        setState(() {});
        _editedProduct.id = productId;
      } else {
        categoriesController.text = 'select categorie';
        marquesController.text = 'select marque';
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState.validate()) {
      return null;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id == null) {
      try {
        await Products().addProduct(_editedProduct).then(
              (_) => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Product Added with seccus!'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    )
                  ],
                ),
              ),
            );
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    } else {
      try {
        await Products().updateProduct(_editedProduct, prodDoc).then(
              (_) => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Product updeted with seccus!'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    )
                  ],
                ),
              ),
            );
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Product',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      controller: _titleController,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: value.trim(),
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          categories: _editedProduct.categories,
                          marques: _editedProduct.marques,
                          id: _editedProduct.id,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: _priceController,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          price: double.parse(value),
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          categories: _editedProduct.categories,
                          marques: _editedProduct.marques,
                          id: _editedProduct.id,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      controller: _descriptionController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: value.trim(),
                          categories: _editedProduct.categories,
                          marques: _editedProduct.marques,
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                        );
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: const Text(
                              'Product',
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: const Text(
                              'Marque',
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("categories")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var docs = snapshot.data.docs;
                                _dropdownValueCat.add(
                                  DropdownMenuItem<String>(
                                    value: 'empty categorie',
                                    child: Text(
                                      'empty categorie',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                );
                                for (int i = 0; i < docs.length; i++) {
                                  _dropdownValueCat.add(
                                    DropdownMenuItem<String>(
                                      value: docs[i]['title'],
                                      child: Text(
                                        docs[i]['title'],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return DropdownButton<String>(
                                  value: categoriesController.text.isNotEmpty
                                      ? null
                                      : categoriesController.text,
                                  icon: Icon(
                                    Icons.arrow_downward,
                                  ),
                                  iconSize: 20,
                                  elevation: 16,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.purple,
                                  ),
                                  hint: Text(
                                    '${categoriesController.text}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  onChanged: (String newValue) {
                                    final snackbar = SnackBar(
                                      content: Text(
                                        'Selected currency value is  "$newValue"',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                    setState(() {
                                      categoriesController.text = newValue;
                                      _editedProduct = Product(
                                        title: _editedProduct.title,
                                        price: _editedProduct.price,
                                        description: _editedProduct.description,
                                        categories: newValue,
                                        marques: _editedProduct.marques,
                                        imageUrl: _editedProduct.imageUrl,
                                        id: _editedProduct.id,
                                      );
                                    });
                                  },
                                  items: _dropdownValueCat,
                                );
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("marques")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var docs = snapshot.data.docs;
                                _dropdownValueMar.add(
                                  DropdownMenuItem<String>(
                                    value: 'empty marque',
                                    child: Text(
                                      'empty marque',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                );
                                for (int i = 0; i < docs.length; i++) {
                                  _dropdownValueMar.add(
                                    DropdownMenuItem<String>(
                                      value: docs[i]['title'],
                                      child: Text(
                                        docs[i]['title'],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return DropdownButton<String>(
                                  value: marquesController.text.isNotEmpty
                                      ? null
                                      : marquesController.text,
                                  icon: Icon(
                                    Icons.arrow_downward,
                                  ),
                                  iconSize: 20,
                                  elevation: 16,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.purple,
                                  ),
                                  hint: Text(
                                    '${marquesController.text}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  onChanged: (String newValue) {
                                    final snackbar = SnackBar(
                                      content: Text(
                                        'Selected currency value is  "$newValue"',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                    setState(() {
                                      marquesController.text = newValue;
                                      _editedProduct = Product(
                                        title: _editedProduct.title,
                                        price: _editedProduct.price,
                                        description: _editedProduct.description,
                                        categories: _editedProduct.categories,
                                        marques: newValue,
                                        imageUrl: _editedProduct.imageUrl,
                                        id: _editedProduct.id,
                                      );
                                    });
                                  },
                                  items: _dropdownValueMar,
                                );
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.purple,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a Image')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image URL';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                categories: _editedProduct.categories,
                                marques: _editedProduct.marques,
                                imageUrl: value.trim(),
                                id: _editedProduct.id,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
