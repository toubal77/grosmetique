import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grosmetique/widgets/categories/buildProdCategorie.dart';

class BuildSearch extends SearchDelegate {
  List list;
  BuildSearch({this.list});

  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for AppBar
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon Leading
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Future getDataSearch() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    var _products = snapshot.docs;
    var _prod = _products.firstWhere((prod) => prod.data()['title'] == query);
    return _prod;
  }

  @override
  Widget buildResults(BuildContext context) {
    // Results search
    return FutureBuilder(
      future: getDataSearch(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Center(
            child: BuildProdCategorie(snapshot.data, snapshot.data.id),
          );
        }
        if (snapshot.data == null) {
          return Center(child: Text('No result found'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searchers for something
    var searchList =
        query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    print(searchList);
    return searchList.isEmpty
        ? Center(child: Text("no result found"))
        : ListView.builder(
            itemCount: searchList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = searchList[index];
                  showResults(context);
                },
                title: RichText(
                  text: TextSpan(
                    text: searchList[index].substring(0, query.length),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: searchList[index].substring(query.length),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                leading: Icon(Icons.access_alarm),
                trailing: Icon(Icons.navigate_next),
              );
            },
          );
  }
}
