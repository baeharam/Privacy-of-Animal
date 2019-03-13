import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/validation/validator.dart';
import 'package:rxdart/rxdart.dart';

class ValidationBloc extends Object 
  with EmailValidator,PasswordValidator,NameValidator,AgeValidator
  ,JobValidator,GenderValidator,NickNameValidator,TagValidator
  implements BlocBase {

  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  final BehaviorSubject<int> _ageController = BehaviorSubject<int>(seedValue: null);
  final BehaviorSubject<String> _jobController = BehaviorSubject<String>();
  final BehaviorSubject<String> _genderController = BehaviorSubject<String>(seedValue: null);
  final BehaviorSubject<String> _nickNameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _tagController = BehaviorSubject<String>();

  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;
  Function(String) get onNameChanged => _nameController.sink.add;
  Function(String) get onJobChanged => _jobController.sink.add;
  Function(String) get onNickNameChanged => _nickNameController.sink.add;
  Function(String) get onTagChanged => _tagController.sink.add;
  onAgeSelected(int age) => _ageController.sink.add(age);
  onGenderSelected(String gender) => _genderController.sink.add(gender);

  onAccountFailed() {
    onEmailChanged('');
    onPasswordChanged('');
  }

  onProfileFailed() {
    onNameChanged(null);
    onJobChanged(null);
    onAgeSelected(-1);
    onGenderSelected(null);
  }

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<String> get name => _nameController.stream.transform(validateName);
  Stream<String> get job => _jobController.stream.transform(validateJob);
  Stream<int> get age => _ageController.stream.transform(validateAge);
  Stream<String> get gender => _genderController.stream.transform(validateGender);
  Stream<String> get nickName => _nickNameController.stream.transform(validateNickName);
  Stream<String> get tag => _tagController.stream.transform(validateTag);

  Stream<bool> get loginValid => Observable.combineLatest2(email,password, (e,p) => true);
  Stream<bool> get signUpValid => 
    Observable.combineLatest7(email,password,name,age,job,gender,nickName, (e,p,n,a,j,g,nn) => true);

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _ageController.close();
    _jobController.close();
    _genderController.close();
    _nickNameController.close();
    _tagController.close();
  }
}
