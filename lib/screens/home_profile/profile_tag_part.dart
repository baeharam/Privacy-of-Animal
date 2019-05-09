import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/logics/tag_edit/tag_edit.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_dialog.dart';

class ProfileTagPart extends StatefulWidget {
  @override
  _ProfileTagPartState createState() => _ProfileTagPartState();
}

class _ProfileTagPartState extends State<ProfileTagPart> {
  @override
  Widget build(BuildContext context) {

    final CurrentUser _user = sl.get<CurrentUser>();
    final TagEditBloc _tagEditBloc = sl.get<TagEditBloc>();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: ScreenUtil.width/20),
        child: BlocBuilder(
          bloc: _tagEditBloc,
          builder: (context, TagEditState state){
            if(state.isShowDialog){
              streamDialogEditTag(context,state.tagIndex,state.dropDownItems);
              _tagEditBloc.emitEvent(TagEventStateClear());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: ProfileTagElement(content: _user.tagListModel.tagTitleList[0],isTitle: true),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 0))
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: ProfileTagElement(content: _user.tagListModel.tagDetailList[0],isTitle: false),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 0))
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: ProfileTagElement(content: _user.tagListModel.tagTitleList[1],isTitle: true),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 1))
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: ProfileTagElement(content: _user.tagListModel.tagDetailList[1],isTitle: false),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 1))
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: ProfileTagElement(content: _user.tagListModel.tagTitleList[2],isTitle: true),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 2))
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: ProfileTagElement(content: _user.tagListModel.tagDetailList[2],isTitle: false),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 2))
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: ProfileTagElement(content: _user.tagListModel.tagTitleList[3],isTitle: true),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 3))
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: ProfileTagElement(content: _user.tagListModel.tagDetailList[3],isTitle: false),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 3))
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: ProfileTagElement(content: _user.tagListModel.tagTitleList[4],isTitle: true),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 4))
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: ProfileTagElement(content: _user.tagListModel.tagDetailList[4],isTitle: false),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 4))
                    )
                  ],
                )
              ],
            );
          }
        )
      ),
    );
  } 
}

class ProfileTagElement extends StatelessWidget {
  final String content;
  final bool isTitle;
  ProfileTagElement({@required this.content, @required this.isTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: isTitle ? primaryBlue : primaryGreen,
          width: 3.0
        )
      ),
      child: Text(
        '# $content'
      ),
    );
  }
}