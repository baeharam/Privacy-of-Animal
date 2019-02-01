import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/models/real_profile_model.dart';
import 'package:privacy_of_animal/models/signup_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/sub/signup_gender_select.dart';
import 'package:privacy_of_animal/screens/sub/signup_input.dart';
import 'package:privacy_of_animal/utils/age_picker.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/primary_button.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _jobFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      _nameController.dispose();
      _ageController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _nameFocusNode.dispose();
      _jobFocusNode.dispose();
      super.dispose();
    }

  Widget _buildTitle(String title){
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18.0
        ),
      ),
    );
  }

  Widget _buildIntroduction(String introduction, EdgeInsets padding){
    return Padding(
      padding: padding,
      child: Text(
        introduction,
        style: TextStyle(
          color: primaryPink,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final ValidationBloc validationBloc = sl.get<ValidationBloc>();
    final SignUpBloc signUpBloc = sl.get<SignUpBloc>();
    SignUpModel signUpModel = SignUpModel();

    return Container(
      height: ScreenUtil.height*1.2,
      width: ScreenUtil.width/1.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildIntroduction('계정을 입력해주세요.', EdgeInsets.only(bottom: 20.0)),
          _buildTitle('이메일'),
          SignUpInput(
            hintText: signUpEmailHint,
            stream: validationBloc.email,
            controller: _emailController,
            focusNode: _emailFocusNode,
            failFocusNode: _emailFocusNode,
            onChanged: validationBloc.onEmailChanged,
            textInputType: TextInputType.emailAddress,
            type: FOCUS_TYPE.ACCOUNT_FOCUS,
          ),
          SizedBox(height: ScreenUtil.height/25),
          _buildTitle('비밀번호'),
          SignUpInput(
            hintText: signUpPasswordHint,
            stream: validationBloc.password,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            failFocusNode: _emailFocusNode,
            onChanged: validationBloc.onPasswordChanged,
            textInputType: TextInputType.emailAddress,
            type: FOCUS_TYPE.ACCOUNT_FOCUS,
            obscureText: true,
          ),
          SizedBox(height: ScreenUtil.height/25),
          _buildIntroduction('프로필을 입력해주세요.', EdgeInsets.symmetric(vertical: 20.0)),
          _buildTitle('이름'),
          SignUpInput(
            hintText: signUpNameHint,
            stream: validationBloc.name,
            controller: _nameController,
            focusNode: _nameFocusNode,
            failFocusNode: _nameFocusNode,
            onChanged: validationBloc.onNameChanged,
            textInputType: TextInputType.text,
            type: FOCUS_TYPE.PROFILE_FOCUS
          ),
          SizedBox(height: ScreenUtil.height/25),
          _buildTitle('나이'),
          BlocBuilder(
            bloc: signUpBloc,
            builder: (BuildContext context, SignUpState state){
              if(state.isAgeSelected){
                _ageController.text = '${state.age.toString()}살';
              }
              if(state.isAccountRegisterFailed || state.isRegistered){
                _ageController.clear();
              }
              return GestureDetector(
                child: Container(
                  color: Colors.transparent,
                  child: IgnorePointer(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: signUpAgeHint
                      ),
                      controller: _ageController,
                    ),
                  ),
                ),
                onTap: () => state.isRegistering ? null : showAgePicker(context),
              );
            },
          ),
          SizedBox(height: ScreenUtil.height/25),
          _buildTitle('직업'),
          SignUpInput(
            hintText: signUpJobHint,
            stream: validationBloc.job,
            controller: _jobController,
            focusNode: _jobFocusNode,
            failFocusNode: _nameFocusNode,
            onChanged: validationBloc.onJobChanged,
            textInputType: TextInputType.text,
            type: FOCUS_TYPE.PROFILE_FOCUS
          ),
          SizedBox(height: ScreenUtil.height/15),
          _buildTitle('성별'),
          SizedBox(height: ScreenUtil.height/30),
          BlocBuilder(
            bloc: signUpBloc,
            builder: (context, SignUpState state){
              if(state.isMaleSelected || state.isFemaleSelected){
                signUpModel.realProfileModel = RealProfileModel(gender: state.gender);
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SignUpGenderSelect(genderTitle: '남자',signUpEvent: SignUpEventMaleSelect(),isSelected: state.isMaleSelected),
                  SizedBox(width: ScreenUtil.width/10),
                  SignUpGenderSelect(genderTitle: '여자',signUpEvent: SignUpEventFemaleSelect(),isSelected: state.isFemaleSelected)
                ],
              );
            },
          ),
          SizedBox(height: ScreenUtil.height/15),
          StreamBuilder<bool>(
            stream: validationBloc.signUpValid,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
              return PrimaryButton(
                text: '회원가입',
                color: primaryBeige,
                callback: (snapshot.hasData && snapshot.data==true) 
                ? (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  signUpModel.realProfileModel.name = _nameController.text;
                  signUpModel.realProfileModel.age = _ageController.text;
                  signUpModel.realProfileModel.job = _jobController.text;
                  signUpModel.email = _emailController.text;
                  signUpModel.password = _passwordController.text;
                  signUpBloc.emitEvent(SignUpEventComplete(data: signUpModel));
                } 
                : null,
              );
            },
          )
        ],
      ),
    );
  }
}