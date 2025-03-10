import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_clone/src/actions/auth/search_users.dart';
import 'package:instagram_clone/src/actions/auth/start_following.dart';
import 'package:instagram_clone/src/actions/auth/stop_following.dart';
import 'package:instagram_clone/src/actions/chats/create_chat.dart';
import 'package:instagram_clone/src/containers/user_container.dart';
import 'package:instagram_clone/src/containers/users_search_result_container.dart';
import 'package:instagram_clone/src/models/app_state.dart';
import 'package:instagram_clone/src/models/auth/app_user.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);
  static const String id = 'SearchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _query = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Material(
            color: Theme.of(context).bottomAppBarColor,
            elevation: 6.0,
            child: Container(
              padding: EdgeInsetsDirectional.only(top: MediaQuery.of(context).padding.top),
              margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: TextField(
                controller: _query,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'username, email or name',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (String value) {
                  StoreProvider.of<AppState>(context).dispatch(SearchUsers(value));
                },
              ),
            ),
          ),
          Flexible(
            child: UserContainer(
              builder: (BuildContext context, AppUser currentUser) {
                return UsersSearchResultContainer(
                  builder: (BuildContext context, List<AppUser> users) {
                    if (users.isEmpty) {
                      return const Center(
                        child: Text('Enter a value to search.'),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        final AppUser user = users[index];
                        final bool isFollowing = currentUser.following.contains(user.uid);

                        return ListTile(
                          title: Text(user.displayName),
                          subtitle: Text(user.email),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.message),
                                onPressed: () {
                                  StoreProvider.of<AppState>(context).dispatch(CreateChat(user.uid));
                                  Navigator.pushNamed(context, '/messages');
                                },
                              ),
                              IconButton(
                                icon: Icon(isFollowing ? Icons.close : Icons.person_add),
                                onPressed: () {
                                  if (isFollowing) {
                                    StoreProvider.of<AppState>(context).dispatch(StopFollowing(user.uid));
                                  } else {
                                    StoreProvider.of<AppState>(context).dispatch(StartFollowing(user.uid));
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
