import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class TagState extends BlocState {
  final bool isTagSelected;
  final int tagIndex;
  final bool isTagCompleted;
  final bool isImageLoaded;
  final List<int> image;

  TagState({
    this.isTagSelected: false,
    this.tagIndex: -1,
    this.isTagCompleted: false,
    this.isImageLoaded: false,
    this.image
  });

  factory TagState.initial() => TagState();

  factory TagState.selected(int index){
    return TagState(
      isTagSelected: true,
      tagIndex: index
    );
  }

  factory TagState.imageLoaded(List<int> image, int index){
    return TagState(
      isImageLoaded: true,
      image: image,
      tagIndex: index
    );
  }


}