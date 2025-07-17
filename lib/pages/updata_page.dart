import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  File? _selectedImage;


  // Future<void> _pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _selectedImage = File(pickedFile.path);
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color.fromRGBO(63, 81, 243, 1),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Add Product ',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Center(

        child: Container(
          decoration: BoxDecoration(),
          padding: const EdgeInsets.all(12),

          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SingleChildScrollView(
              child: Column(
              
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 366,
                        height: 190,

                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: _selectedImage != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedImage!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined, size: 48),
                              SizedBox(height: 8),
                              Text('upload image', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    width: 366,
                    height: 50,
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    //   borderRadius: BorderRadiusDirectional.circular(5),
                    // ),
                    child: TextField(

                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Text(
                    'category',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    width: 366,
                    height: 50,

                    child: TextField(

                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Text(
                    'Price',

                    style: TextStyle(

                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    width: 366,
                    height: 50,
                    // decoration: BoxDecoration(
                    //     border: Border.all(),
                    //   borderRadius: BorderRadiusDirectional.circular(5),
                    //
                    // ),
                    child: TextField(
                      textAlign: TextAlign.center,

                      decoration: (const InputDecoration(border: InputBorder.none,hintText:  '                                                             \$ ')


                      )
                    ),
                  ),
                  Text(
                    'description',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    width: 366,
                    height: 140,
                    // decoration: BoxDecoration(
                    //     border: Border.all(),
                    //   borderRadius: BorderRadiusDirectional.circular(5),
                    //
                    // ),
                    child: TextField(
                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
              
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('ADD'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(63, 81, 243, 1),
                        foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
              
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                      ),
              
                      child: ElevatedButton(
              
                        onPressed: () {},
                        child: Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
