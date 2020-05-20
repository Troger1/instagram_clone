import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_clone/src/actions/auth/logout.dart';
import 'package:instagram_clone/src/models/app_state.dart';
import 'add_post_screen.dart';
import 'feed_screen.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  static const String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController tabController;
  int page = 0;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () async {
              StoreProvider.of<AppState>(context).dispatch(Logout());
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
           const FeedScreen(),
          Container(color: Colors.green),
          Container(color: Colors.lightBlue),
          Container(color: Colors.blueGrey),
        ],
      ),
      bottomSheet: BottomNavigationBar(
        onTap: (int index) {
          if (index == 2) {
        

            Navigator.push(
              context,
              MaterialPageRoute<void>(
                fullscreenDialog: true,
                builder: (BuildContext context) {
                  return const AddPostScreen();
                },
              ),
            );
          } else {
            setState(() => page = index);
            if (index > 2) {
              index--;
            }

            tabController.animateTo(index);
          }
        },
        currentIndex: page,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: const Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: const Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            title: const Text('Add post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: const Text('Favorite'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: const Text('Profile'),
          ),
        ],
      ),
    );
  }
}
