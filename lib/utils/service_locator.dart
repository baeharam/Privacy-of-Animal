import 'package:get_it/get_it.dart';
import 'package:privacy_of_animal/logics/find_password/find_password_bloc.dart';
import 'package:privacy_of_animal/logics/initialize_api.dart';
import 'package:privacy_of_animal/logics/login/login_bloc.dart';
import 'package:privacy_of_animal/logics/signup/signup_bloc.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat_bloc.dart';
import 'package:privacy_of_animal/logics/tag_select/tag_select_bloc.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';

GetIt sl = GetIt();

void setup() {
  sl.registerSingleton<InitializeAPI>(InitializeAPI());
  sl.registerSingleton<LoginBloc>(LoginBloc());
  sl.registerSingleton<SignUpBloc>(SignUpBloc());
  sl.registerSingleton<FindPasswordBloc>(FindPasswordBloc());
  sl.registerSingleton<ValidationBloc>(ValidationBloc());
  sl.registerSingleton<TagSelectBloc>(TagSelectBloc());
  sl.registerSingleton<TagChatBloc>(TagChatBloc());
}