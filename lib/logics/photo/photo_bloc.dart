import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';

class PhotoBloc extends BlocEventStateBase<PhotoEvent,PhotoState>
{
  static final PhotoAPI _api = PhotoAPI();

  @override
  PhotoState get initialState => PhotoState.noTake();

  @override
  Stream<PhotoState> eventHandler(PhotoEvent event, PhotoState currentState) async*{
    
    if (event is PhotoEventTaking) {
      String path = await _api.getImage();
      yield PhotoState.take(path);
    }
    if (event is PhotoEventGotoAnalysis){
      yield PhotoState.analysis();
    }
  }
}