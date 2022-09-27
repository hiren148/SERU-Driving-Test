import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_item_state.dart';

class BottomItemCubit extends Cubit<BottomItemState> {
  BottomItemCubit() : super(BottomItemHome('Home is Active'));

  int _pos = 0;

  int get pos => _pos;

  void onItemTapped(int index) {
    if (index < 0 || index > 3) throw StateError('index can not be $index');
    _pos = index;
    switch (index) {
      case 1:
        emit(BottomItemLearn('Learn is Active'));
        break;
      case 2:
        emit(BottomItemTest('Test is Active'));
        break;
      case 3:
        emit(BottomItemProfile('Profile is Active'));
        break;
      case 0:
      default:
        emit(BottomItemHome('Home is Active'));
    }
  }
}
