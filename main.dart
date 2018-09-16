// -- Data Type --

class User {
  final String name;
  final int salary;

  User([this.name = '☁️', this.salary = 9000]);
}

// -- State: บอกว่าเก็บข้อมูลอะไรบ้าง --
class State {
  final List<User> users;

  State({this.users = const []});
}

// -- Action: บอกว่าจะทำอะไร --

abstract class UserAction {}

class AddUser extends UserAction {
  final String name;
  final int salary;

  AddUser([this.name, this.salary]);
}

// -- Reducer: บอกว่าจะเปลี่ยนแปลงข้อมูลอย่างไร --

List<User> userReducer(List<User> state, UserAction action) {
  if (action is AddUser) {
    return <User>[]
      ..addAll(state)
      ..add(User(action.name, action.salary));
  }

  return state;
}

// -- Root Reducer: รวบ Reducer ทุกตัว แล้วเอามาสร้าง State ใหม่

State rootReducer(State state, dynamic action) {
  return State(users: userReducer(state.users, action));
}

// ลองรันดูกัน!

void main() {
  final state = State();
  final action = AddUser('🐘');

  final newState = rootReducer(state, action);
  print("New State: ${newState.users.map((x) => x.name)}");
}
