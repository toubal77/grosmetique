import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/categories/buildStreamCategories.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewCategories(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          BuildStreamCategories(),
        ],
      ),
    );
  }
}

void _startAddNewCategories(BuildContext ctx) {
  showModalBottomSheet(
    context: ctx,
    builder: (bCtx) {
      return GestureDetector(
        child: AddNewCategories(),
      );
    },
  );
}

class AddNewCategories extends StatefulWidget {
  @override
  _AddNewCategoriesState createState() => _AddNewCategoriesState();
}

class _AddNewCategoriesState extends State<AddNewCategories> {
  final _titleController = TextEditingController();
  final _imageUrlController = TextEditingController();

  void _submitForm() async {
    try {
      if (_titleController.text.isEmpty || _imageUrlController.text.isEmpty) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Values Can\'t be empty'),
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
      } else {
        await FirebaseFirestore.instance.collection('categories').add({
          'title': _titleController.text,
          'imageUrl': _imageUrlController.text,
        }).then(
          (_) => showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Categories Added with seccus!'),
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
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 35.0,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 5.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Text(
              'Add New Categories',
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.purple,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Categories Title',
                labelStyle: TextStyle(color: Colors.black38),
              ),
              controller: _titleController,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Categories ImageUrl',
                labelStyle: TextStyle(color: Colors.black38),
              ),
              controller: _imageUrlController,
            ),
          ),
          Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: TextButton(
              child: Text(
                'submit',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20.0,
                ),
              ),
              onPressed: _submitForm,
            ),
          ),
        ],
      ),
    );
  }
}
