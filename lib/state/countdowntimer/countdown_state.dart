part of 'countdown_cubit.dart';

@immutable
abstract class CountdownState {}

class CountdownIdeal extends CountdownState {}

class CountdownOnTick extends CountdownState {}

class CountdownFinish extends CountdownState {}
