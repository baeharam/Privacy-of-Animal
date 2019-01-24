import 'package:privacy_of_animal/bloc_helpers/bloc_provider.dart';
import 'package:privacy_of_animal/logics/validation/email_validator.dart';
import 'package:privacy_of_animal/logics/validation/password_validator.dart';
import 'package:rxdart/rxdart.dart';

class ValidationBloc extends Object with EmailValidator, PasswordValidator implements BlocBase {

  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  Stream<bool> get loginValid => Observable.combineLatest2(email, password, (e,p) => true);

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
