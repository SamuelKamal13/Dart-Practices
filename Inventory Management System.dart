import 'dart:io';

List<Map<String, dynamic>> products = [];

bool isRunning = true;

void main() {
  while (isRunning) {
    inventoryActions();
  }
}

void inventoryActions() {
  stdout.write("""===== Inventory Management System =====

1. Add Product
2. View Products
3. Search Product
4. Update Product Quantity
5. Delete Product
6. Calculate Inventory Value
7. Exit

Choose an option: """);

  String? userAction = stdin.readLineSync();

  switch (userAction) {
    case "1":
      addProduct();
      break;

    case "2":
      viewProducts();
      break;

    case "3":
      searchProduct();
      break;

    case "4":
      updateProductQuantity();
      break;

    case "5":
      deleteProduct();
      break;

    case "6":
      calculateInventory();
      break;

    case "7":
      isRunning = false;
      break;

    default:
      print("Please enter a number between 1 and 7");
  }
}

void addProduct() {
  print("\n===== Add Product =====\n");
  stdout.write("ID: ");
  String? productID = stdin.readLineSync();
  productID = productID?.trim();
  if (productID == null || productID.isEmpty) {
    print("Product ID can not be empty");
  } else if (products.any((product) => product['id'] == productID)) {
    print("There is a product with the same ID");
  } else {
    stdout.write("Product Name: ");
    String? productName = stdin.readLineSync();
    productName = productName?.trim();

    if (productName == null || productName.isEmpty) {
      print("Product name can not be empty");
    } else {
      stdout.write("Quantity: ");
      String? quantity = stdin.readLineSync();
      int? productQuantity = int.tryParse(quantity ?? "");

      if (productQuantity == null) {
        print("Product quantity can not be empty or alphabet");
      } else {
        if (productQuantity <= 0) {
          print("Product quantity must be greater than 0");
        } else {
          stdout.write("Price: ");
          String? price = stdin.readLineSync();
          double? productPrice = double.tryParse(price ?? "");

          if (productPrice == null) {
            print("Product price can not be empty or alphabet");
          } else {
            if (productPrice <= 0) {
              print("Product price can not be 0 or less");
            } else {
              products.add({
                "id": productID,
                "name": productName,
                "quantity": productQuantity,
                "price": productPrice,
              });
              print("\nProduct added sucssefully!\n");
            }
          }
        }
      }
    }
  }
}

void viewProducts() {
  print("\n===== View All Products =====\n");

  if (products.isEmpty) {
    print("There are no products to show");
  } else {
    for (var product in products) {
      print("""ID: ${product['id']}
Name: ${product['name']}
Quantity: ${product['quantity']}
Price: ${product['price']} EGP
""");
    }
  }
}

void searchProduct() {
  print("\n===== Search For A Product =====\n");
  stdout.write("Enter product ID: ");

  String? search = stdin.readLineSync();
  search = search?.trim();

  if (search == null || search.isEmpty) {
    print("ID can not be empty");
  } else {
    Map<String, dynamic> result = products.firstWhere(
      (map) => map['id'] == search,
      orElse: () => {},
    );
    if (result.isEmpty) {
      print("There is no product with this ID");
    } else {
      print("""\n===== Product Found =====\n
ID: ${result['id']}
Name: ${result['name']}
Quantity: ${result['quantity']}
Price: ${result['price']}\n""");
    }
  }
}

void updateProductQuantity() {
  print("\n===== Search For A Product =====\n");
  stdout.write("Product ID: ");
  String? id = stdin.readLineSync();
  id = id?.trim();

  if (id == null || id.isEmpty) {
    print("ID can not be empty");
  } else {
    Map<String, dynamic> productToUpdate = products.firstWhere(
      (map) => map['id'] == id,
      orElse: () => {},
    );
    if (productToUpdate.isEmpty) {
      print("There is no product with this ID");
    } else {
      print("Current Quantity: ${productToUpdate['quantity']}\n");

      stdout.write("Enter New Quantity: ");
      String? quantity = stdin.readLineSync();
      int? newQuantity = int.tryParse(quantity ?? "");

      if (newQuantity == null) {
        print("New quantity can not be empty");
      } else if (newQuantity < 0) {
        print("New quantity can not be less than 0");
      } else {
        productToUpdate['quantity'] = newQuantity;
        print("\nQuantity updated successfully!\n");
      }
    }
  }
}

void deleteProduct() {
  print("\n===== Delete Product =====\n");
  stdout.write("Product ID: ");
  String? id = stdin.readLineSync();
  id = id?.trim();

  if (id == null || id.isEmpty) {
    print("ID can not be empty");
  } else {
    Map<String, dynamic> deletedProduct = products.firstWhere(
      (map) => map['id'] == id,
      orElse: () => {},
    );
    if (deletedProduct.isEmpty) {
      print("There is no product with this ID");
    } else {
      products.removeWhere((map) => map['id'] == id);
      print("\nProduct deleted sucssesfuly\n");
    }
  }
}

void calculateInventory() {
  double totalValue = 0;
  for (var product in products) {
    totalValue += product['quantity'] * product['price'];
  }
  print("\nTotal Inventory Value = ${totalValue} EGP\n");
}
