import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/signup_model.dart';

abstract class SignUpEvent extends BlocEvent{}

class SignUpEventClear extends SignUpEvent {}
class SignUpEventInitial extends SignUpEvent {}

class SignUpEventAgeSelect extends SignUpEvent {
  final int age;

  SignUpEventAgeSelect({this.age});
}

class SignUpEventMaleSelect extends SignUpEvent {}
class SignUpEventFemaleSelect extends SignUpEvent {}

class SignUpEventComplete extends SignUpEvent {
  final SignUpModel data;

  SignUpEventComplete({
    @required this.data
  });
}