// Restaurant Card Widget (Place in your main list/grid)
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
//Map here late all category
          margin: const EdgeInsets.only(right: 8),

          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),          ),

            child: Text('Category'  + 'category2'),



        ),

        const SizedBox(height: 24,),


        Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'section',
                  style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 16,),
                  //TODO Change ListView later when retrieving from DB
                  // ListView(

                  //   children: [
                  //     Padding(padding: 
                      
                  //     const EdgeInsets.symmetric(vertical: 8),
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,

                  //       children: [
                  //         Container(

                  //           width: 80,
                  //           height: 80,
                  //           decoration: BoxDecoration(
                              
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //     )
                  //   ],
                  // )
                ],
        )
      ],
    ),
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

