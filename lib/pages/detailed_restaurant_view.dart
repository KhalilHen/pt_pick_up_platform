import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/controllers/category_controller.dart';
import 'package:pt_pick_up_platform/controllers/menu_controller.dart';
import 'package:pt_pick_up_platform/custom/custom_menu.dart';
import 'package:pt_pick_up_platform/models/category.dart';
import 'package:pt_pick_up_platform/models/menu_section.dart';
import 'package:pt_pick_up_platform/models/restaurant.dart';

import '../models/restaurant_category.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;
   RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customWidgets = customMenuWidgets();
    final categoryController = CategoryController();
    final menuController = MenuController1();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            backgroundColor: Colors.deepOrange,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'restaurant-${restaurant.id}', 
                child: Image.network(
                  restaurant.imgUrl ?? 'https://www.bartsboekje.com/wp-content/uploads/2020/06/riccardo-bergamini-O2yNzXdqOu0-unsplash-scaled.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(restaurant.name),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          Text(
                            ' ${restaurant.rating.toStringAsFixed(1)} ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' ${restaurant.reviewCount} reviews',
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


    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
      child: 
        Text(
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer tincidunt sem congue, malesuada enim sit amet, ornare ipsum. Pellentesque enim elit, interdum eget facilisis nec, congue condimentum diam. In tristique in mauris a malesuada. Cras consectetur lorem at lacus venenatis, non tristique neque gravida. Aenean non viverra nisi. Nullam vitae dolor egestas, viverra nisi a, ultricies justo. Nulla non nisi ligula. In tristique auctor leo.'
,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(

            color: Colors.grey[600],
            fontSize: 16,
          ),
        ) 
      ),
    ),

                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FutureBuilder<List<Category>>(
                          future: categoryController.fetchRestaurantCategory(restaurantId: restaurant.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              print(snapshot.error);
                              return Center(child: Text('Error loading categories'));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('No categories available'));
                            } else {
                              final categories = snapshot.data!;
                              return Row(
                                children: categories.map((category) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(category.name),
                                  );
                                }).toList(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Menu Sections 
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: restaurant.menuSections!.map((section) {
                  //     return customWidgets.buildMenuSection(context, {
                  //       'id': section.id,
                  //       'title': section.name,
                  //     });
                  //   }).toList(),
                  // ),
            

            FutureBuilder<List<MenuSection>>( 
              
                  // print('restaurant.id: ${restaurant.id}');
                future: menuController.fetchMenuSections(restaurantId: restaurant.id),


            
            builder:  (context, snapshot)  {


              if(snapshot.connectionState == ConnectionState.waiting) {

          return Center(child: CircularProgressIndicator());
              
              }
               if(snapshot.hasError) {
                print(snapshot.data);

                      print(snapshot.error);
                return   const Center(child: CircularProgressIndicator());

             
             
              }
              else if (!snapshot.hasData || snapshot.data!.isEmpty) {

                return const Center(child: Text('No menu sections is avaibel!'));

              }
            
            List<MenuSection>?  sections = snapshot.data!;

            if(sections.isEmpty || sections == null) {
              return const Center(child: Text('No menu sections is avaibel!'));
            }
           return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: sections.map((section) {
    // Debugging: Print each section's data
    print('Section ID: ${section.id}, Section Name: ${section.name}');

    // Handle sections with missing or empty names
    final sectionName = section.name.isEmpty ? 'Unnamed Section' : section.name;

    // Call buildMenuSection with the actual model
    return customWidgets.buildMenuSection(context, {
      'id': section.id,
      'title': section.name,
    });
  }).toList(),
           );

            }
            
            
            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
