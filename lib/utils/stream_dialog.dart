import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/find_password/find_password.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/logics/tag_edit/tag_edit.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void streamDialogEditTag(BuildContext context, int tagIndex, List<String> dropDownItems) {

  final ValidationBloc validationBloc = sl.get<ValidationBloc>();
  final TagEditBloc tagEditBloc = sl.get<TagEditBloc>();
  final TextEditingController tagController = TextEditingController();
  String selectedTag = sl.get<CurrentUser>().tagListModel.tagTitleList[tagIndex];

  WidgetsBinding.instance.addPostFrameCallback((_){
    Alert(
      context: context,
      title: '관심사 수정',
      content: BlocBuilder(
        bloc: tagEditBloc,
        builder: (context,TagEditState state){
          if(state.isTagChanged){
            selectedTag = state.currentTag;
          }
          if(state.isLoading){
            return CustomProgressIndicator();
          }
          return Column(
            children: <Widget>[
              DropdownButton<String>(
                value: selectedTag,
                items: dropDownItems.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (tag) => sl.get<TagEditBloc>().emitEvent(TagEditEventMenuChange(changedTag: tag))
              ),
              StreamBuilder<String>(
                stream: validationBloc.tag,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  return TextField(
                    decoration: InputDecoration(
                      labelText: tagToMessage[selectedTag],
                      errorText: snapshot.error,
                    ),
                    onChanged: validationBloc.onTagChanged,
                    keyboardType: TextInputType.text,
                    controller: tagController,
                  );
                },
              )
            ],
          );
        }
      ),
      buttons: [
        DialogButton(
          onPressed: () {tagEditBloc.emitEvent(
              TagEditEventSubmit(tagTitle: selectedTag, tagDetail: tagController.text, tagIndex: tagIndex)
            );
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.pop(context);
          },
          child: Text(
            '수정',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: primaryGreen
        ),
        DialogButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.pop(context);
          },
          child: Text(
            '취소',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: Colors.red
        )
      ]
    ).show();
  });
}

void streamDialogForgotPassword(BuildContext context) {

  final ValidationBloc validationBloc = sl.get<ValidationBloc>();
  final FindPasswordBloc findPasswordBloc = sl.get<FindPasswordBloc>();
  final TextEditingController _emailController = TextEditingController();

  WidgetsBinding.instance.addPostFrameCallback((_){
    Alert(
      context: context,
      title: '비밀번호 찾기',
      content: Column(
        children: <Widget>[
          StreamBuilder<String>(
            stream: validationBloc.email,
            initialData: loginEmptyEmailError,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return TextField(
                decoration: InputDecoration(
                  labelText: '이메일',
                  errorText: snapshot.error,
                ),
                onChanged: validationBloc.onEmailChanged,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController
              );
            },
          )
        ],
      ),
      desc: findPasswordMessage,
      buttons: [
        DialogButton(
          onPressed: (){
            findPasswordBloc.emitEvent(FindPasswordEventForgotPasswordButton(email: _emailController.text));
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.pop(context);
          },
          child: Text(
            '확인',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: primaryGreen,
        )
      ]
    ).show();
  });
}

void streamDialogSignUpFailed(BuildContext context,String title,String message,FAIL_TYPE type) {

  final ValidationBloc validationBloc = sl.get<ValidationBloc>();
  final SignUpBloc signUpBloc = sl.get<SignUpBloc>();
  
  WidgetsBinding.instance.addPostFrameCallback((_){
    Alert(
      context: context,
      title: title,
      desc: message,
      type: AlertType.error,
      buttons: [
        DialogButton(
          onPressed: (){
            type==FAIL_TYPE.ACCOUNT_FAIL ? validationBloc.onAccountFailed() : validationBloc.onProfileFailed();
            signUpBloc.emitEvent(SignUpEventInitial());
            Navigator.pop(context);
          },
          child: Text(
            '닫기',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: primaryPink,
        )
      ]
    ).show();
  });
}

enum FAIL_TYPE {
  ACCOUNT_FAIL,
  PROFILE_FAIL
}