import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../utils/product.dart';

class SearchPage extends StatefulWidget {
   SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage> {
  RangeValues values = const RangeValues(20, 80);
  @override
  Widget build(BuildContext context) {
    RangeLabels labels = RangeLabels(
      values.start.toString(),
      values.end.toString(),
    );

  TextEditingController _categoryController = TextEditingController();
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(63, 81, 243, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,

        title: Text(
          'Search Product',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.only(left: 0),


              child: Row(


                children: [
                  Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Search'),
                        SizedBox(
                          width: 200,
                        ),
                        Icon(

                          Icons.arrow_forward,
                          color: Color.fromRGBO(63, 81, 243, 1),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.indeterminate_check_box_rounded,
                    color: Color.fromRGBO(63, 81, 243, 1),
                    size: 69,
                  ),
                ],
              ),
            ),
            Expanded(

              child: ListView.builder(itemBuilder: (context,index){
                return Product();

              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(


                children: [

                  Text('Category', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',

                  ),
                  )
                  ,Container(
                    height: 40,
                    width: 366,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(

                      decoration: InputDecoration(

                        border: InputBorder.none,
                      ),

                    ),
                  )
                  ,SizedBox(height: 16,),
                  Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 11.0,

                    activeTrackColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                  ),
                  child: RangeSlider(
                    values: values,
                    min: 0,
                    max: 100,

                    activeColor: Color.fromRGBO(63, 81, 243, 1),
                    inactiveColor: Colors.grey,

                    labels: RangeLabels(
                      values.start.round().toString(),
                      values.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                         values= values;
                      });
                    },
                  ),
                ),


                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the sheet
                        print("Category: ${_categoryController.text}");
                        print("Price: $values");
                        // Use filter values in your main screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(63, 81, 243, 1),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("APPLY", style: TextStyle(color: Colors.white),),
                    ),
                  ),

                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}
