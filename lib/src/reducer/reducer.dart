import 'package:instagram_clone/src/actions/actions.dart';
import 'package:instagram_clone/src/reducer/comments_reducer.dart';
import 'package:instagram_clone/src/models/app_state.dart';
import 'package:instagram_clone/src/reducer/post_reducer.dart';
import 'package:instagram_clone/src/reducer/auth_reducer.dart';

import 'auth_reducer.dart';
import 'chats_reducer.dart';
import 'likes_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is ErrorAction) {
    final dynamic error = action.error;
    try {
      print('error: $error');
      print('stacktrace: ${error.stackTrace}');
    } catch (_) {}
  }

  print(action);
  return state.rebuild((AppStateBuilder b) {
    b
      ..auth = authReducer(state.auth, action).toBuilder()
      ..posts = postReducer(state.posts, action).toBuilder()
      ..comments = commentsReducer(state.comments, action).toBuilder()
      ..likes = likesReducer(state.likes, action).toBuilder()
      ..chats = chatsReducer(state.chats, action).toBuilder();
  });
}

