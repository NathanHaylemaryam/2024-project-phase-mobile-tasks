import 'package:flutter/material.dart';

import '../pages/details._page.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Card(
          elevation: 5,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),

          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsPage()),
                ),
                child: Image.asset('lib/images/1.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'KYRIE 4 HALLOWEEN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('578', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mens shoe',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(170, 170, 170, 1),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          (Icons.star_rate_rounded),
                          color: Color.fromRGBO(255, 215, 0, 1),
                        ),
                        Text(
                          '( 5.0)',
                          style: TextStyle(
                            color: Color.fromRGBO(170, 170, 170, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 5,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),

          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsPage()),
                ),
                child: Image.asset('lib/images/1 (1).jpg'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'KYRIE 5 Friends',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('378', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mens shoe',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(170, 170, 170, 1),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          (Icons.star_rate_rounded),
                          color: Color.fromRGBO(255, 215, 0, 1),
                        ),
                        Text(
                          '( 4.7)',
                          style: TextStyle(
                            color: Color.fromRGBO(170, 170, 170, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 5,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),

          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsPage()),
                ),
                child: Image.asset('lib/images/21.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'KYRIE 7 BROOKLYN BEATS',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('162', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mens shoe',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(170, 170, 170, 1),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          (Icons.star_rate_rounded),
                          color: Color.fromRGBO(255, 215, 0, 1),
                        ),
                        Text(
                          '( 4.0)',
                          style: TextStyle(
                            color: Color.fromRGBO(170, 170, 170, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),


      ]




    );
  }
}
