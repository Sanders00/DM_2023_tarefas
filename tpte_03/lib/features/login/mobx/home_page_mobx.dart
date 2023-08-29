import 'package:mobx/mobx.dart';

part 'home_page_mobx.g.dart';

class HomePageMobx = _HomePageMobx with _$HomePageMobx;

abstract class _HomePageMobx with Store {
  @observable
  bool _vaidPassword = false;
  @observable
  bool _validEmail = false;
  @observable
  bool _remeberUser = false;

  bool get validPassword => _vaidPassword;
  set newValidPassword(bool newValidPassword) =>
      _vaidPassword = newValidPassword;

  bool get validEmail => _validEmail;
  set newValidEmail(bool newValidEmail) => _validEmail = newValidEmail;

  bool get remeberUser => _remeberUser;
  set newRemeberUser(bool newRemeberUser) => _remeberUser = newRemeberUser;
}
