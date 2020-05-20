library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:instagram_clone/src/models/comments/comment.dart';
import 'package:instagram_clone/src/models/posts/post.dart';
import 'package:instagram_clone/src/models/posts/posts_state.dart';
import 'package:instagram_clone/src/models/posts/save_post_info.dart';

import 'app_state.dart';
import 'auth/app_user.dart';
import 'auth/auth_state.dart';
import 'auth/registration_info.dart';
import 'comments/comments_state.dart';
import 'likes/like.dart';
import 'likes/like_type.dart';
import 'likes/likes_state.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[
  AppState,
  AppUser,
  RegistrationInfo,
  Post,
  SavePostInfo,
  Comment,
  AuthState,
  PostsState,
  CommentsState,
  LikesState,
  Like,
  LikeType,
])
Serializers serializers = (_$serializers.toBuilder() //
      ..addPlugin(StandardJsonPlugin()))
    .build();
