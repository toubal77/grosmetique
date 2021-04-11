import 'package:flutter/material.dart';
import 'package:grosmetique/screens/admin/users/detail_user_screen.dart';

class BuildUserListTile extends StatelessWidget {
  final users;
  BuildUserListTile(this.users);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          UserDetailScreen.routeName,
          arguments: users['id_user'],
        );
      },
      child: SingleChildScrollView(
        child: ListTile(
          title: Text(
            users['username'],
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
          ),
          subtitle: Text(users['email']),
          trailing: Container(
            width: 70,
            child: Row(
              children: <Widget>[
                Text(
                  users['status_admin'] ? 'admin' : 'suscriber',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.purple,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.navigate_next,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
