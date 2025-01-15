import 'package:flutter/material.dart';
import '../main.dart';


 class  customMenuWidgets {

//Mock data
  final List<Map<String, dynamic>> menuSections = [
    {
      'title': 'Section 1',
      'items': [
        Icon(Icons.home),
        Icon(Icons.star),
        Icon(Icons.settings),
      ],
    },
    {
      'title': 'Section 2',
      'items': [
        Icon(Icons.person),
        Icon(Icons.shopping_cart),
        Icon(Icons.favorite),
      ],
    },
    {
      'title': 'Section 3',
      'items': [
        Icon(Icons.map),
        Icon(Icons.phone),
        Icon(Icons.camera),
      ],
    },
  ];





  Widget buildMenuSection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16,),
        ListView.separated(

          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            // return buildMenuItem (                    );
            
          },
        ),
       
     
      ],
    );
  }

 }