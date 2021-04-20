import 'package:todo/models1/todo.dart';
import 'package:todo/repositories/repository.dart';

class TodoService {
  Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  //* Create Todo
  saveTodo(Todo todo) async {
    return await _repository.insertData('todos', todo.todoMap());
  }

  //* read Todos
  readTodos() async {
    return await _repository.readData('todos');
  }

  //* Read Todos by Category
  readTodosByCategory(category) async {
    return await _repository.readDataByColumnName(
        'todos', 'category', category);
  }

  //* Delete Todo
  deleteTodo(todoId) async {
    return await _repository.deleteData('todos', todoId);
  }
}
