

import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String name;
  final String decscription;
  final String price;


  final String imagepath;

  final int id;



  const Product(
  {
    required this.name,
    required this.decscription,
    required this.price,
    required this.imagepath,
    required this.id,


}
      );
  @override
  List<Object> get props => [id , name , decscription , price, imagepath];
}