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


   ],
          ),



      );

  }


  }

