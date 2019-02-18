import 'package:get_it/get_it.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list_bloc.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/find_password/find_password_bloc.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/friend_request/friend_request_bloc.dart';
import 'package:privacy_of_animal/logics/friends/friends_bloc.dart';
import 'package:privacy_of_animal/logics/home/home_bloc.dart';
import 'package:privacy_of_animal/logics/initialize_api.dart';
import 'package:privacy_of_animal/logics/login/login_bloc.dart';
import 'package:privacy_of_animal/logics/profile/profile_bloc.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/logics/signup/signup_bloc.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat_bloc.dart';
import 'package:privacy_of_animal/logics/tag_edit/tag_edit_bloc.dart';
import 'package:privacy_of_animal/logics/tag_select/tag_select_bloc.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/logics/photo/photo_bloc.dart';

GetIt sl = GetIt();

void setup() {
  sl.registerLazySingleton<InitializeAPI>(()=> InitializeAPI());
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  sl.registerLazySingleton<FirebaseAPI>(() => FirebaseAPI());
  sl..registerLazySingleton<RandomChatBloc>(() => RandomChatBloc());
  sl.registerSingleton(CurrentUser());
  
  sl.registerLazySingleton<LoginBloc>(()=> LoginBloc());
  sl.registerLazySingleton<SignUpBloc>(()=> SignUpBloc());
  sl.registerLazySingleton<FindPasswordBloc>(()=> FindPasswordBloc());
  sl.registerLazySingleton<ValidationBloc>(()=> ValidationBloc());
  sl.registerLazySingleton<TagSelectBloc>(()=> TagSelectBloc());
  sl.registerLazySingleton<TagChatBloc>(()=> TagChatBloc());
  sl.registerLazySingleton<PhotoBloc>(()=>PhotoBloc());
  sl.registerLazySingleton<HomeBloc>(() => HomeBloc());
  sl.registerLazySingleton<TagEditBloc>(() => TagEditBloc());
  sl.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
  sl.registerLazySingleton<FriendRequestBloc>(() => FriendRequestBloc());
  sl.registerLazySingleton<ChatListBloc>(() => ChatListBloc());
  sl.registerLazySingleton<FriendsBloc>(() => FriendsBloc());
}