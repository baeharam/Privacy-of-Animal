import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/tag_select/tag_select.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'package:privacy_of_animal/widgets/primary_button.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class TagSelectScreen extends StatefulWidget {
  @override
  _TagSelectScreenState createState() => _TagSelectScreenState();
}

class _TagSelectScreenState extends State<TagSelectScreen> {

  @override
  Widget build(BuildContext context) {

    final TagSelectBloc _tagBloc = sl.get<TagSelectBloc>();
    List<bool> isActivateList = List.generate(tags.length, (i) => false);

    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        children:<Widget>[
          Container(
            padding: EdgeInsets.only(top: ScreenUtil.height/30),
            child: Text(
              '관심있는 태그 5개만 선택해주세요!',
              style: TextStyle(
                color: primaryPink,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: tags.length,
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20.0),
            itemBuilder: (BuildContext context, int index){
              return  BlocBuilder(
                bloc: _tagBloc,
                builder: (context, TagSelectState state){
                  if(state.isTagActivated && state.tagIndex==index){
                    isActivateList[index] = true;
                  }
                  else if(state.isTagDeactivated && state.tagIndex==index){
                    isActivateList[index] = false;
                  }
                  return GestureDetector(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image(
                          image: tags[index].image,
                          width: ScreenUtil.width/3.5,
                          height: ScreenUtil.width/3.5
                        ),
                        Container(
                          width: ScreenUtil.width/3.5-10.0,
                          height: ScreenUtil.width/3.5-10.0,
                          decoration: BoxDecoration(
                            color: isActivateList[index] ? Colors.black.withOpacity(0.5) : Colors.transparent,
                            shape: BoxShape.circle
                          ),
                        ),
                        Positioned(
                          bottom: 20.0,
                          child: Text(
                            tags[index].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      if(isActivateList[index]){
                        _tagBloc.emitEvent(TagSelectEventDeactivate(index: index));
                      }
                      else if(!isActivateList[index]){
                        _tagBloc.emitEvent(TagSelectEventActivate(index: index));
                      }
                    },
                  );
                }
              );
            }
          ),
          BlocBuilder(
            bloc: _tagBloc,
            builder: (_, TagSelectState state){
              if(state.isTagCompleted){
                StreamNavigator.pushReplacementNamed(context, routeTagChat);
              }
              if(state.isTagLoading){
                return CustomProgressIndicator();
              }
              if(state.isTagFailed){
                streamSnackbar(context,'태그등록에 실패했습니다.');
              }
              return PrimaryButton(
                text: '선택 완료',
                color: primaryBeige,
                callback: () => _tagBloc.emitEvent(TagSelectEventComplete(isTagSelected: isActivateList))
              );
            }
          )
        ]
      )
    );
  }
}