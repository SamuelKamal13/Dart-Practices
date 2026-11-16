import 'dart:io';

Map<String, double> userExpenses = {};

bool isRunning = true;

void main() {
  while (isRunning) {
    expenseActions();
  }
}

void expenseActions() {
  stdout.write("""===== Expense Tracker =====

1. Add Expense
2. View Expenses
3. Search Category
4. Delete Category
5. View Total Expenses
6. Exit

Choose an option: """);
  String? userAction = stdin.readLineSync();

  switch (userAction) {
    case "1":
      addExpense();
      break;

    case "2":
      viewExpense();
      break;

    case "3":
      searchExpense();
      break;

    case "4":
      deleteExpense();
      break;

    case "5":
      totalExpense();
      break;

    case "6":
      exit();
      break;

    default:
      print("Invaild choice, Please enter a number between 1 and 6");
  }
}

void addExpense() {
  print("\n===== Add Expense =====\n");
  stdout.write("Category: ");
  String? category = stdin.readLineSync();
  category = category?.trim();

  if (category == null || category.isEmpty) {
    print("Category can not be empty");
  } else {
    stdout.write("Amount: ");
    String? amount = stdin.readLineSync();
    double? expenseAmount = double.tryParse(amount ?? "");

    if (expenseAmount == null || expenseAmount <= 0) {
      print("Invalid amount");
    } else {
      if (userExpenses.containsKey(category)) {
        double sum = expenseAmount + userExpenses[category]!;
        userExpenses[category] = sum;
      } else {
        userExpenses[category] = expenseAmount;
      }
      print("Expense added successfully!\n");
    }
  }
}

void viewExpense() {
  if (userExpenses.isEmpty) {
    print("No expenses found.");
  } else {
    print("\n===== Your Expenses =====\n");
    for (var entry in userExpenses.entries) {
      print("${entry.key}: ${entry.value} EGP");
    }
  }
}

void searchExpense() {
  if (userExpenses.isEmpty) {
    print("\nThere is no expenses to search for\n");
  } else {
    stdout.write("""\n===== Search Expenses =====
  
Category: """);

    String? userSearch = stdin.readLineSync();
    userSearch = userSearch?.trim();

    if (userSearch == null || userSearch.isEmpty) {
      print("Category can not be empty");
    } else {
      if (userExpenses.containsKey(userSearch)) {
        print("Total spent: ${userExpenses[userSearch]} EGP");
      } else {
        print("Invalid category!");
      }
    }
  }
}

void deleteExpense() {
  if (userExpenses.isEmpty) {
    print("\nThere are no expenses to delete\n");
  } else {
    stdout.write("""\n===== Delete Expense =====
  
Category: """);

    String? deletedExpense = stdin.readLineSync();
    deletedExpense = deletedExpense?.trim();

    if (deletedExpense == null || deletedExpense.isEmpty) {
      print("Category can not be empty");
    } else {
      if (userExpenses.containsKey(deletedExpense)) {
        userExpenses.remove(deletedExpense);
        print("Expense deleted sucssefully");
      } else {
        print("Invalid category");
      }
    }
  }
}

void totalExpense() {
  if (userExpenses.isEmpty) {
    print("\nThere are no expenses to calculate total expenses\n");
  } else {
    double sum = 0;
    print("\n===== Total Expenses =====\n");
    for (var entry in userExpenses.values) {
      sum += entry;
    }
    print("Total Expenses: ${sum} EGP");
  }
}

void exit() {
  isRunning = false;
}
