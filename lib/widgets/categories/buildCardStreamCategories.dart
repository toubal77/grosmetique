import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildCardStreamCategories extends StatelessWidget {
  BuildCardStreamCategories(this.docs);
  final QueryDocumentSnapshot docs;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  docs['imageUrl'],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  docs['title'],
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.purple,
                      ),
                      onPressed: () =>
                          _startEditCategories(context, docs['title']),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.purple,
                      ),
                      onPressed: () => _deleteCategories(docs['title']),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _deleteCategories(String deleteTitle) async {
  var snapshot =
      await FirebaseFirestore.instance.collection('categories').get();
  var _cats = snapshot.docs;
  var _idDelete =
      _cats.firstWhere((cat) => cat.data()['title'] == deleteTitle).id;
  await FirebaseFirestore.instance
      .collection('categories')
      .doc(_idDelete)
      .delete();
}

void _startEditCategories(BuildContext ctx, String editTitle) {
  showModalBottomSheet(
    context: ctx,
    builder: (bCtx) {
      return GestureDetector(
        child: EditCategories(editTitle),
      );
    },
  );
}

class EditCategories extends StatefulWidget {
  final editTitle;
  EditCategories(this.editTitle);
  @override
  _EditCategoriesState createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  final _titleController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String _idEdit;
  var _isLoading = false;
  @override
  void initState() {
    _findCategories();
    super.initState();
  }

  void _findCategories() async {
    setState(() {
      _isLoading = true;
    });
    var snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    var _cats = snapshot.docs;
    var _cat =
        _cats.firstWhere((cat) => cat.data()['title'] == widget.editTitle);
    _idEdit = _cat.id;
    _titleController.text = _cat['title'];
    _imageUrlController.text = _cat['imageUrl'];
    setState(() {
      _isLoading = false;
    });
  }

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
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(_idEdit)
            .set({
          'title': _titleController.text,
          'imageUrl': _imageUrlController.text,
        }).then(
          (_) => showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('${_titleController.text} Edit with seccus!'),
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
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Fieled to edit categorie'),
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
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
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
