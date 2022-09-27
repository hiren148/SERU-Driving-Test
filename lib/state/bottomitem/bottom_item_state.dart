part of 'bottom_item_cubit.dart';

@immutable
abstract class BottomItemState {}

class BottomItemHome extends BottomItemState {
  final String message;

  BottomItemHome(this.message);
}

class BottomItemLearn extends BottomItemState {
  final String message;

  BottomItemLearn(this.message);
}

class BottomItemTest extends BottomItemState {
  final String message;

  BottomItemTest(this.message);
}

class BottomItemProfile extends BottomItemState {
  final String message;

  BottomItemProfile(this.message);
}
