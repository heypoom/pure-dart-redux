class Todo {
  final String name;

  Todo(this.name);
}

// -- State: บอกว่าเก็บข้อมูลอะไรบ้าง --

class State {
  final List<Todo> todos;

  State({this.todos = const []});
}

// -- Action: บอกว่าจะทำอะไร --

abstract class TodoAction {}

class AddTodo extends TodoAction {
  final String name;

  AddTodo(this.name);
}

// -- Reducer: บอกว่าจะเปลี่ยนแปลงข้อมูลอย่างไร --

List<Todo> TodoReducer(List<Todo> state, TodoAction action) {
  if (action is AddTodo) {
    return <Todo>[]
      ..addAll(state)
      ..add(Todo(action.name));
  }

  return state;
}

// -- Root Reducer: รวบ Reducer ทุกตัว แล้วเอามาสร้าง State ใหม่

State rootReducer(State state, dynamic action) {
  return State(todos: TodoReducer(state.todos, action));
}

// ลองรันดูกัน!

void main() {
  final state = State();
  final action = AddTodo("Buy Milk");

  final newState = TodoReducer(state.todos, action);

  final moreAction = AddTodo("Buy Socks");
  final moreState = TodoReducer(newState, moreAction);

  print("State is ${moreState.map((x) => x.name)}");
}
