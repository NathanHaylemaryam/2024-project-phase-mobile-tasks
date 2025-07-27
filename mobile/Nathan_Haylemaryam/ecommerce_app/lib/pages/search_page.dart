import 'package:flutter/material.dart';

import '../utils/shoe_product.dart';

class SearchPage extends StatefulWidget {
   const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage> {
  RangeValues values = const RangeValues(20, 80);
  @override
  Widget build(BuildContext context) {
    RangeLabels _ = RangeLabels(
      values.start.toString(),
      values.end.toString(),
    );


    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(63, 81, 243, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,

        title: const Text(
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
                      color: const Color.fromRGBO(217, 217, 217, 1),
                    ),
                    child: const Row(

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

                  const Icon(
                    Icons.indeterminate_check_box_rounded,
                    color: Color.fromRGBO(63, 81, 243, 1),
                    size: 69,
                  ),
                ],
              ),
            ),
            Expanded(

              child: ListView.builder(itemBuilder: (context,index){
                return const Product();

              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(


                children: [

                  const Text('Category', style: TextStyle(
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
                    child: const TextField(

                      decoration: InputDecoration(

                        border: InputBorder.none,
                      ),

                    ),
                  )
                  ,const SizedBox(height: 16,),
                  const Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
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

                    activeColor: const Color.fromRGBO(63, 81, 243, 1),
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


                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the sheet

                        // Use filter values in your main screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('APPLY', style: TextStyle(color: Colors.white),),
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
