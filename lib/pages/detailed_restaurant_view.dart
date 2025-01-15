import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/custom/custom_menu.dart';
// import 'package:pt_pick_up_platform/widgets/custom_widgets.dart'; // Add this line to import CustomWidgets

class RestaurantDetailPage extends StatelessWidget {
   RestaurantDetailPage({
    Key? key,
  }) : super(key: key);



//Mock data
  final List<Map<String, dynamic>> menuSections = [
    {
      'title': 'Section 1',
      'items': [
        {'name': 'Edamame', 'description': 'Steamed soybeans', 'price': 5.99},
        {'name': 'Miso Soup', 'description': 'Soybean paste soup', 'price': 3.99},
        {'name': 'Gyoza', 'description': 'Pan-fried dumplings', 'price': 4.99},
        {'name': 'California Roll', 'description': 'Crab, avocado, cucumber', 'price': 6.99},
        {'name': 'Spicy Tuna Roll', 'description': 'Tuna, spicy mayo, cucumber', 'price': 7.99},
        {'name': 'Dragon Roll', 'description': 'Shrimp tempura, eel, avocado', 'price': 9.99},
      ],
    },
   
  ];

  @override
  Widget build(BuildContext context) {

    final  customWidgets = customMenuWidgets();
      return  Scaffold(



          body: CustomScrollView(


          slivers: [


SliverAppBar(

    expandedHeight: 200.0, //or 300 not sure yet
    pinned: true,
    backgroundColor: Colors.deepOrange,
    flexibleSpace: FlexibleSpaceBar(
    
        background: Hero(tag: 
        'restaurant', child: Image.network('https://www.bartsboekje.com/wp-content/uploads/2020/06/riccardo-bergamini-O2yNzXdqOu0-unsplash-scaled.jpg',
        fit: BoxFit.cover,)),



      title: Text('Sensei Sushi'),  
    ),



)     ,  
  SliverToBoxAdapter(

    child: Padding(padding: const EdgeInsets.all(16),
    
    
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          Text(
                            ' 3.5 ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' 120 reviews)',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '30 min',
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
//TODO Improve later the category
 SingleChildScrollView(

    scrollDirection: Axis.horizontal,


    child: Row(

      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('Category 1'),
        ),
        Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('Category 2'),
        ),
      ],
    ),
 ),                  
        const SizedBox(height: 24,),


        Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: menuSections.map((section) {
                  return customWidgets.buildMenuSection(context, section);
                }).toList(),
        )
      ],
    ),
    ),

  ),

   ],
          ),



      );

  }


  }

