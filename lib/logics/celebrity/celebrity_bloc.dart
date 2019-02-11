import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/celebrity/celebrity.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class CelebrityBloc extends BlocEventStateBase<CelebrityEvent,CelebrityState>
{
  static final CelebrityAPI _api = CelebrityAPI();

  @override
  CelebrityState get initialState => CelebrityState.loading();

  @override
  Stream<CelebrityState> eventHandler(CelebrityEvent event, CelebrityState currentState) async*{
    if(event is CelebrityEventGetImage){
      
    }
  }
}