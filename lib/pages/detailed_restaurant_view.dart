import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/custom/custom_menu.dart';
import 'package:pt_pick_up_platform/models/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customWidgets = customMenuWidgets();
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
                  const SizedBox(height: 16),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
