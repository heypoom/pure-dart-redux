import 'package:meta/meta.dart';

// -- State: บอกว่าเก็บข้อมูลอะไรบ้าง --

@immutable
class State {
  final String user;

  State({this.user = '☁️'});
}

// -- Action: บอกว่าจะทำอะไร --

class SetUserAction {
  final String name;

  SetUserAction(this.name);
}

// -- Reducer: บอกว่าจะเปลี่ยนแปลงข้อมูลอย่างไร --

String setUserReducer(String state, SetUserAction action) {
  return action.name;
}

// -- Root Reducer: รวบ Reducer ทุกตัว แล้วเอามาสร้าง State ใหม่

State rootReducer(State state, dynamic action) {
  return State(user: setUserReducer(state.user, action));
}

void main() {
  final state = State();
  print('Initial User State: ${state.user}');

  final action = SetUserAction('🐸');

  final user = setUserReducer(state.user, action);
  print('User: $user');

  final newState = rootReducer(state, action);
  print('New User State: ${newState.user}');
}
