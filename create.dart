import 'package:meta/meta.dart';

class User {
  final String name;
  final int salary;

  User({this.name, this.salary});
}

// -- State: บอกว่าเก็บข้อมูลอะไรบ้าง --

@immutable
class State {
  final List<User> users;

  State({this.users = const []});
}

// -- Action: บอกว่าจะทำอะไร --

abstract class UserAction {}

class AddUser extends UserAction {
  final String name;
  final int salary;

  AddUser(this.name, this.salary);
}

// -- Reducer: บอกว่าจะเปลี่ยนแปลงข้อมูลอย่างไร --

List<User> UserReducer(List<User> state, UserAction action) {
  if (action is AddUser) {
    return <User>[]
      ..addAll(state)
      ..add(User(name: action.name, salary: action.salary));
  }

  return state;
}

// -- Root Reducer: รวบ Reducer ทุกตัว แล้วเอามาสร้าง State ใหม่

State rootReducer(State state, dynamic action) {
  return State(users: UserReducer(state.users, action));
}

void main() {
  final state = State();
  print('Initial User State: ${state.users}');

  final action = AddUser('Mr. 🐸', 9000);

  final users = UserReducer(state.users, action);
  print('User: ${users.map((x) => x.name)}');

  final newState = rootReducer(state, action);
  print('New User State: ${newState.users.map((x) => x.name)}');
}
