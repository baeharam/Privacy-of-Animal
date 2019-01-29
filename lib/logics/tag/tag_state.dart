import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class TagState extends BlocState {
  final bool isTagSelected;
  final int tagIndex;
  final bool isTagCompleted;
  final bool isImageLoaded;
  final List<int> compressedImage;

  TagState({
    this.isTagSelected: false,
    this.tagIndex: -1,
    this.isTagCompleted: false,
    this.isImageLoaded: false,
    this.compressedImage: const []
  });

  factory TagState.initial() => TagState();

  factory TagState.selected(int index){
    return TagState(
      isTagSelected: true,
      tagIndex: index
    );
  }

  factory TagState.imageLoaded(List<int> compressedImage, int index){
    return TagState(
      isImageLoaded: true,
      tagIndex: index,
      compressedImage: compressedImage
    );
  }


}