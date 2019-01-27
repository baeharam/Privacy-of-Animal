// import 'package:flutter/material.dart';
// import 'package:privacy_of_animal/bloc_helpers/multiple_bloc_provider.dart';
// import 'package:privacy_of_animal/logics/signup/signup.dart';
// import 'package:privacy_of_animal/resources/colors.dart';
// import 'package:privacy_of_animal/resources/constants.dart';
// import 'package:privacy_of_animal/utils/stream_snackbar.dart';
// import 'package:privacy_of_animal/widgets/arc_background.dart';
// import 'package:privacy_of_animal/widgets/signup_profile_form.dart';

// class SignUpProfileScreen extends StatefulWidget {
//   @override
//   _SignUpProfileScreenState createState() => _SignUpProfileScreenState();
// }

// class _SignUpProfileScreenState extends State<SignUpProfileScreen> {

//   @override
//   Widget build(BuildContext context) {

//     final signUpBloc = MultipleBlocProvider.of<SignUpBloc>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               ArcBackground(
//                 backgroundColor: signUpBackgroundColor,
//                 dashColor: signUpBackgroundColor,
//                 title: '회원가입',
//               ),
//               Container(
//                 padding: EdgeInsets.only(
//                   left: ScreenUtil.height/15,right: ScreenUtil.height/15,top: ScreenUtil.height/50,bottom: ScreenUtil.height/30),
//                 child: Text(
//                   '프로필을 기입해주세요.',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18.0
//                   ),
//                 )
//               ),    
//               SignUpProfileForm(),
//               StreamBuilder(
//                 stream: signUpBloc.state,
//                 builder: (BuildContext context, AsyncSnapshot<SignUpState> snapshot){
//                   if(snapshot.hasData && snapshot.data.isFailed){
//                     streamSnackbar(context, '회원가입에 실패했습니다.');
//                     signUpBloc.emitEvent(SignUpEventInitial());
//                   }
//                   return Container();
//                 },
//               )    
//             ]
//           ),
//         ),
//       ),
//     );
//   }
// }