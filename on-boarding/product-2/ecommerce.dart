  import 'dart:io';

  void main() {
    var option;
    print('Welcome to this e-commerce app');
    print(
      '--------------------****************************------------------------',
    );
    ProductManager pm = ProductManager();
    do {
      print('For creating a new data enter 1 ');
      print('for viewing all the data enter 2');
      print('for view in a specific date enter 3');
      print('for editing an existing date enter 4');
      print('for deleting a specific data enter 5');
      print('for existing the program please enter 6');
      option = stdin.readLineSync();
      if (option == '1') {
        print('Please enter the name description and price respectively');
        var name = stdin.readLineSync();
        var description = stdin.readLineSync();
        var price = stdin.readLineSync();
        var nummy = int.parse(price ?? '0');
        Product p = Product(name, description, nummy);
        // ProductManager pm = ProductManager();
        pm.addProduct(p.name, p.description, p.price);
      } else if (option == '2') {
        // ProductManager pm = ProductManager();
        if (pm.database.isNotEmpty) {
          pm.viewAllProduct();
        } else {
          print('the are no products in the database');
        }
      } else if (option == '3') {
        print('enter the name of the product you want to see');
        var namesee = stdin.readLineSync();
        // ProductManager pm = ProductManager();
        if (pm.database.containsKey(namesee)) {
          pm.viewSingeProduct(namesee);
        } else {
          print('there is no such data in our database');
        }
      } else if (option == '4') {
        print('enter the old name of the data to edit');
        var oldname = stdin.readLineSync();
        // ProductManager pm = ProductManager();

        if (pm.database.containsKey(oldname)) {
          // print(
          //   'enter the what you want to change 1 for name 2 for description 3 for price',
          // );
          // var newName = stdin.readLineSync();
          pm.editProduct(oldname);
        } else {
          print('no such name exist in the database');
        }
      } else if (option == '5') {
        // ProductManager pm = ProductManager();
        print('enter the name of the product to delete');
        var nametodelete = stdin.readLineSync();
        if (pm.database.containsKey(nametodelete)) {
          pm.deleteProduct(nametodelete);
        } else {
          print('there is no such data to delete');
        }
      }
    } while (option != '6');
    print(
      "\n .................................*****************************.............................",
    );
    print('thanks for using our product');
  }

  class Product {
    //  making all the attributes of the product private
    String? _name, _description;
    int? _price;
    Product(String? name, description, int? price) {
      this._name = name;
      this._description = description;
      this._price = price;
    }
    // getter
    String? get name => _name;
    String? get description => _description;
    int? get price => _price;

    // setters
    set name(String? value) => _name = value;
    set description(String? value) => _description = value;
    set price(int? value) {
      if (value != null && value >= 0) {
        _price = value;
      } else {
        print("Price must be a non-negative number");
      }
    }
  }

  class ProductManager {
    var database = {};
    // method to add a new product

    void addProduct(String? name, description, int? price) {
      Product p = Product(name, description, price);

      database[p.name] = [p.description, p.price];

      print('Data added successfully');
    }

    // method to view all product
    void viewAllProduct() {
      if (database.isNotEmpty) {
        print('\n .............. The current data .................. \n');
        for (var data in database.entries) {
          var name = data.key;
          var description = data.value[0];
          var price = data.value[1];

          print('Name: $name \n');
          print('Description: $description \n');
          print('Price: \$${price}\n');
        }
        print("\n ........................*************............. \n");
      } else {
        print(' \n Sorry we have any data yet \n');
      }
    }

    // method to view single product

    void viewSingeProduct(String? name) {
      if (database.containsKey(name)) {
        print('\n .............. The current data .................. \n');
        print("Product Name: $name \n");
        var product = database[name];
        print("Description: $product[0] \n");
        print("Price: $product[1] \n");
        print("\n ........................*************............. \n");
      }
    }

    // method to edit product

    void editProduct(String? name) {
      print(
        'enter what you want to edit for name(n) , for description(d) , for price(p)',
      );
      var choice = stdin.readLineSync();
      if (choice == 'd') {
        print('enter the new description: ');
        var des = stdin.readLineSync();
        database[name][0] = des;
        print('description changed successfully');
                print("\n ........................*************............. \n");

      } else if (choice == 'p') {
        print('enter the new price');
        var pri = stdin.readLineSync();
        var num1 = int.parse(pri ?? '0');
        database[name][1] = num1;
        print('price changed successfully');
                print("\n ........................*************............. \n");

      } else if (choice == 'n') {
        List data = database[name];
        print(data);
        database.remove(name);
        print('enter the new name of you product');
        var newName = stdin.readLineSync();
        database[newName] = [data];
        print('the name has been changed successfully');
                print("\n ........................*************............. \n");

      }
    }

    // method to delete a product
    void deleteProduct(String? name) {
      if (database.containsKey(name)) {
        database.remove(name);
        print('date deleted successfully');
                print("\n ........................*************............. \n");

      } else {
        print('there is no such data make sure you have the correct data');
      }
    }
  }
