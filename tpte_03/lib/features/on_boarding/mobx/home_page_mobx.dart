import 'package:mobx/mobx.dart';

part 'home_page_mobx.g.dart';

class HomePageMobx = _HomePageMobx with _$HomePageMobx;

abstract class _HomePageMobx with Store {
  @observable
  int _currentPage = 0;

  int get currentPage => _currentPage;

  set newCurrentPage(int newCurrentPage) => _currentPage = newCurrentPage;
}
