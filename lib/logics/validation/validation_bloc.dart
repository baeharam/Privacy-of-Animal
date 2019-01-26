import 'package:privacy_of_animal/bloc_helpers/bloc_provider.dart';
import 'package:privacy_of_animal/logics/validation/validator.dart';
import 'package:privacy_of_animal/utils/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class ValidationBloc extends Object 
  with EmailValidator,PasswordValidator,NameValidator,AgeValidator,JobValidator implements BlocBase {

  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _ageController = BehaviorSubject<String>();
  final BehaviorSubject<String> _jobController = BehaviorSubject<String>();  

  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;
  Function(String) get onNameChanged => _nameController.sink.add;
  Function(String) get onAgeChanged => _ageController.sink.add;
  Function(String) get onJobChanged => _jobController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<String> get name => _nameController.stream.transform(validateName);
  Stream<String> get age => _ageController.stream.transform(validateAge);
  Stream<String> get job => _jobController.stream.transform(validateJob);


  Stream<bool> get loginValid => Observable.combineLatest2(email, password, (e,p) => true);
  Stream<bool> get signUpProfileValid => Observable.combineLatest3(name,age,job, (n,a,j) => true);

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _ageController.close();
    _jobController.close();
  }
}
