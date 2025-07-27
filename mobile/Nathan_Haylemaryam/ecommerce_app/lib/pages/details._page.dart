import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}
// wokring on a new branch
class _DetailsPageState extends State<DetailsPage> {
  int selectedSize = 8;

  // Track selected size
  List<int> sizes = [39, 40, 41, 42, 43, 44, 45, 46, 47];

  // List of available sizes
  Widget _buildSizeItem(int size) {
    bool isSelected = (selectedSize == size);

    return GestureDetector(
      onTap: () => setState(() => selectedSize = size), // Update selection
      child: Container(
        width: 60, // Fixed width per item
        margin: const EdgeInsets.only(right: 8), // Spacing between items
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromRGBO(63, 81, 243, 1) : Colors.grey[200],
          // Selected color
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        child: Center(
          child: Text(
            size.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,

              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

      ),
      body: Padding(

        padding: const EdgeInsets.all(8.0),
        child: Column(

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
                      MaterialPageRoute(builder: (context) => const DetailsPage()),
                    ),
                    child: Image.asset('lib/images/1.jpg'),
                  ),

                  Container(
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 8, bottom: 0),
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
                  ),
                  Container(
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 8, bottom: 0,),
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
                  ),

                  Container(
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 12, top: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Size: ',
                          textAlign: TextAlign.left,
                          style: TextStyle(

                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(62, 62, 62, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 0, top: 12.0),
                      child: SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sizes.length,
                          itemBuilder: (context, index) {
                            return _buildSizeItem(sizes[index]); // Added missing )
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20 ,top: 12,bottom: 25),
                      child: Text(
                        'The Nike Kyrie 4 suits up for Halloween, featuring an all-black finish on the mesh and nubuck upper. A green slime graphic coats the underside of the glossy black Swoosh and appears to drip dramatically onto the matching black midsole. The black leather tongue tag and the shoes distinctive upward-curving rubber outsole are similarly outfitted in Rage Green.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                  ),
                  // SizedBox(height: 70),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12,top: 12,bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          // SizedBox(height: 25),
                          SizedBox(
                            width: 157,

                            height: 50,

                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(8)
                              ),

                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Delete'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 157,

                            height: 50,

                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('UPDATE'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
