import 'dart:io';

List<String> tasks = [];

bool isRunning = true;

void main() {
  while (isRunning) {
    todoActions();
  }
}

void todoActions() {
  stdout.write("""===== To-Do List Manager =====

1. Add Task
2. View Tasks
3. Delete Task
4. Exit

Choose an option: """);

  String? userAction = stdin.readLineSync();

  switch (userAction) {
    case "1":
      addTask();
      break;

    case "2":
      viewTasks();
      break;

    case "3":
      deleteTask();
      break;

    case "4":
      exit();
      break;

    default:
      print("Please choose from 1 to 4.");
  }
}

void addTask() {
  stdout.write("\nTask Name: ");
  String? userTask = stdin.readLineSync();
  userTask = userTask?.trim();

  if (userTask == null || userTask.isEmpty) {
    print("Task name can not be empty");
  } else {
    tasks.add(userTask);
    print("\nTask added sucssefuly");
    viewTasks();
  }
}

void viewTasks() {
  if (tasks.isEmpty) {
    print("\nNo tasks to show\n");
  } else {
    print("\nYour tasks: ");
    for (int i = 1; i <= tasks.length; i++) {
      print("${i}. ${tasks[i - 1]}");
    }
  }
}

void deleteTask() {
  if (tasks.isEmpty) {
    print("\nNo tasks to delete\n");
  } else {
    for (int i = 1; i <= tasks.length; i++) {
      print("${i}. ${tasks[i - 1]}");
    }
    stdout.write("\nChoose a task to delete: ");
    String? userInput = stdin.readLineSync();
    int? deletedTask = int.tryParse(userInput ?? "");

    if (deletedTask == null) {
      print("Enter a valid task number");
    } else if (deletedTask <= 0 || deletedTask > tasks.length) {
      print("No task with this number");
    } else {
      tasks.removeAt(deletedTask - 1);
      print("Task deleted sucssefully");
      viewTasks();
    }
  }
}

void exit() {
  isRunning = false;
}
