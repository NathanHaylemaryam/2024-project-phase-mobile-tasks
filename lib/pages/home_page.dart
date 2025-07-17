import 'package:e_commerce_project/pages/details._page.dart';
import 'package:e_commerce_project/pages/search_page.dart';
import 'package:e_commerce_project/pages/updata_page.dart';
import 'package:e_commerce_project/utils/product.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Square leading icon
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12), // square with rounded corners
                      ),
                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'July 14, 2023',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Hello, Yohannes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Column with Hello and name


                // Notification icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:  Color.fromRGBO(217, 217, 217, 1),
                        width: 1.5,
                      )
                        ,borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      ),
                      icon: Icon(Icons.search, color: Color.fromRGBO(217, 217, 217, 1),),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(itemBuilder: (context,index){
                return Product();

              }),
                )
          ],
        ),

      ),
      floatingActionButton: SizedBox(
        height: 72,
        width: 72,
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdatePage()),

          ),
          backgroundColor: Color.fromRGBO(63, 81, 243, 1),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
          shape: const CircleBorder(),

        ),
      ),
    );
  }
}
