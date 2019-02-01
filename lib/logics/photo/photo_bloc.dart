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
      _api.data.path = await _api.getImage();
      print(_api.data.path);
      yield PhotoState.take(_api.data.path);
    }
    if (event is PhotoEventGotoAnalysis){
      yield PhotoState.analysis();
    }
  }
}