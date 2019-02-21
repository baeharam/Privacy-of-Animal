import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/tag_select/tag_select.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/back_button_dialog.dart';
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

  final TagSelectBloc _tagBloc = sl.get<TagSelectBloc>();
  List<bool> isActivateList = List.generate(tags.length, (i) => false);
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: WillPopScope(
        onWillPop: () => BackButtonAction.stopInMiddle(context),
        child: SingleChildScrollView(
          controller: scrollController,
          padding: CurrentPlatform.platform==TargetPlatform.iOS 
          ? const EdgeInsets.all(10.0) 
          : const EdgeInsets.only(bottom: 20.0),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
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
                physics: const ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(20.0),
                itemBuilder: (BuildContext context, int index){
                  return  BlocBuilder(
                    bloc: _tagBloc,
                    builder: (context, TagSelectState state){
                      if(state.isTagActivated){
                        if(state.tagIndex==index) isActivateList[index] = true;
                        if(state.selectedTagsLength==5) {
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                        }
                      }
                      else if(state.isTagDeactivated){
                        if(state.tagIndex==index) isActivateList[index] = false;
                        scrollController.animateTo(
                            0.0,duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut);
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
                    _tagBloc.emitEvent(TagSelectEventStateClear());
                  }
                  return PrimaryButton(
                    text: '선택 완료',
                    color: primaryBeige,
                    callback: () => _tagBloc.emitEvent(TagSelectEventComplete(isTagSelected: isActivateList))
                  );
                }
              )
            ]
          ),
        )
      )
    );
  }
}