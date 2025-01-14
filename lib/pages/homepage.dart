import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      
      backgroundColor: Colors.white,


      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Pick-up',
        style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        
        
        
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
       
            
            Expanded(


                  //Category listbuilder
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for items...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),


                  Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  
                  child: Column(


                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                       Text(
                        'Categories',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),

                      const SizedBox(height: 12,),

                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        
                        itemCount: 10, 
                        itemBuilder: (context, index) {
                                    return Container(

                                      width: 90,
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        
                                      ),
                                      child: Column(

                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.fastfood, color: Colors.deepOrange, size: 28,),
                                          SizedBox(height: 8,),
                                          Text('category-title',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,),
                                          )
                                        ],
                                      ),
                                    );
                      
                        },
                      ),
                    ),

                    Padding(padding: const EdgeInsets.symmetric(vertical: 16.0),
                    
                    
                    child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text('Restaurants',

                                    style: Theme.of(context).textTheme.headlineLarge,
                            
                            ),
                            const SizedBox(height: 12,),

                            GridView.builder(
                              
                              
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: screenSize.width < 340 ? 1 : 2,
                            childAspectRatio: (screenSize.width / 2 - 24) / ((screenSize.width / 2 - 24) * 1.2),

                            // childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,

                            
                            
                            ),


                            itemCount: 10,
                            
                            
                            itemBuilder: (context, index) {


                              return Container(

 decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),  
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Expanded(

              flex: 3,
              child: Container(  


                decoration: BoxDecoration(
                  color: Colors.grey[300]
                ,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),


                ),

                child: Center(


                  child:                  Icon(Icons.image,  size: 40, color: Colors.grey,),

                ),

              ),


          ),

          Expanded(
            
            flex: 2,
            child: Padding(padding: const EdgeInsets.all(8.0),
            
            child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
   Text('Restaurant Name',
  
  style: Theme.of(context).textTheme.headlineMedium,
 maxLines: 1,
 overflow: TextOverflow.ellipsis,
  ),
  

  Text('labels/tags',
  style: Theme.of(context).textTheme.bodyMedium,
  ),
  Row(

children: [

  Icon(Icons.star, color: Colors.amber, size: 14,
  
  ),
  Text(                        ' 4.5 · 20min',

  style: TextStyle(fontSize: 12),
  )
],

  ),
],
            ),
            ),


            )
        ],
      ) ,
                              );
                            }
                            
                            
                            
                            )

                          ],

                    ),
                    ),
                    ],
                  ),
                   )

          

             
                ],
              ),

              
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
        ],
      ),
    );
  }


}