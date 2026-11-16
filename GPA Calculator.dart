import 'dart:io';

void main() {
  print("==== Student Report ==== \n");

  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()!;
  name = name.trim();
  if (name.isEmpty) {
    print("Name can not be empty");
    return;
  } else if (num.tryParse(name) != null) {
    print("Name can not be a number");
    return;
  }

  stdout.write("Enter your ID: ");
  String studentId = stdin.readLineSync()!;
  if (studentId.isEmpty) {
    print("ID can not be empty");
    return;
  }

  stdout.write("\nMathematics: ");
  String mathGrade = stdin.readLineSync()!;
  if (mathGrade.isEmpty) {
    print("Grade can not be empty");
    return;
  }

  stdout.write("Programming: ");
  String progGrade = stdin.readLineSync()!;
  if (progGrade.isEmpty) {
    print("Grade can not be empty");
    return;
  }

  stdout.write("English: ");
  String engGrade = stdin.readLineSync()!;
  if (engGrade.isEmpty) {
    print("Grade can not be empty");
    return;
  }

  if (double.tryParse(mathGrade) == null) {
    print("Invalid math grade");
    return;
  }
  if (double.tryParse(progGrade) == null) {
    print("Invalid programming grade");
    return;
  }
  if (double.tryParse(engGrade) == null) {
    print("Invalid english grade");
    return;
  }

  Student student = Student(name: name, id: studentId, grades: [
    double.tryParse(mathGrade)!,
    double.tryParse(progGrade)!,
    double.tryParse(engGrade)!
  ]);
  calculateGrade(student);
}

class Student {
  final String name;
  final String id;
  final List<double> grades;

  Student({required this.name, required this.id, required this.grades});
}

void calculateGrade(Student student) {
  double sum = 0;
  double average = 0;

  if (student.grades.isEmpty) {
    print("Grades can not be empty");
  } else {
    if (student.grades.any((num) => num > 100)) {
      print("Grade can not be greater than 100");
    } else if (student.grades.any((num) => num < 0)) {
      print("Grade can not be less than 0");
    } else {
      for (double grade in student.grades) {
        sum += grade;
      }
      average = sum / student.grades.length;

      studentReport(student, sum, average);
    }
  }
}

void calculateReport(double sum, double average, Student student) {
  print("\nTotal: ${sum} / 300");
  print("Average: ${average}");
  print("Percentage: ${sum / (student.grades.length * 100) * 100}%");
}

void studentReport(Student student, double sum, double avg) {
  print("\n========================\n");
  print("Name: ${student.name}");
  print("ID: ${student.id}");
  print("Mathematics: ${student.grades[0]}");
  print("Programming: ${student.grades[1]}");
  print("English: ${student.grades[2]}");
  calculateReport(sum, avg, student);
  if (avg >= 50) {
    print("\nResult: Passed");
    print("========================");
  } else {
    print("\nResult: Failed");
    print("========================");
  }
}
