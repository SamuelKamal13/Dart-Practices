import 'dart:io';

double userBalance = 5000;

bool isRunning = true;

void main() {
  while (isRunning) {
    chooseOperator();
  }
}

void chooseOperator() {
  print("""===== ATM Simulator =====

1. Check Balance
2. Deposit
3. Withdraw
4. Exit\n""");

  stdout.write("Choose an option: ");
  String? choose = stdin.readLineSync();

  switch (choose) {
    case "1":
      checkBalance();
      break;

    case "2":
      deposit();
      break;

    case "3":
      withdraw();
      break;

    case "4":
      exitATM();
      break;

    default:
      print("Please enter between 1 and 4.");
      break;
  }
}

void checkBalance() {
  print("\nCurrent Balance: ${userBalance} EGP\n");
}

void deposit() {
  stdout.write("\nEnter deposit amount: ");
  String? userInput = stdin.readLineSync();
  double depositAmount = double.tryParse(userInput ?? "") ?? 0;

  if (depositAmount <= 0) {
    print("Invalid amount!");
  } else {
    print("\nDeposit successful!");
    userBalance += depositAmount;
    checkBalance();
  }
}

void withdraw() {
  stdout.write("\nEnter withdraw amount: ");
  String? userInput = stdin.readLineSync();
  double withdrawAmount = double.tryParse(userInput ?? "") ?? 0;

  if (withdrawAmount <= 0 || withdrawAmount > userBalance) {
    print("Invalid amount!");
  } else {
    print("\nWithdraw successful!");
    userBalance -= withdrawAmount;
    checkBalance();
  }
}

void exitATM() {
  isRunning = false;
}
