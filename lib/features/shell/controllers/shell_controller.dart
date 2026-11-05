import 'package:mobx/mobx.dart';
import '../models/shell_navigation_model.dart';

part 'shell_controller.g.dart';

class ShellController = ShellControllerBase with _$ShellController;

abstract class ShellControllerBase with Store {
  @observable
  int currentIndex = 0;

  @observable
  bool showingGarage = false;

  @computed
  ShellTab get currentTab => ShellTab.values[currentIndex];

  @action
  void setIndex(int index) {
    currentIndex = index;
    if (index == 0 && showingGarage) {
      showingGarage = false;
    }
  }

  @action
  void openGarage() {
    currentIndex = 0;
    showingGarage = true;
  }

  @action
  void closeGarage() {
    showingGarage = false;
  }

  @action
  void toggleGarage() {
    showingGarage = !showingGarage;
  }
}
