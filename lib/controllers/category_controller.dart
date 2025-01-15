import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/category.dart';

import '../main.dart';


class CategoryController {



        Future<List<Category>> fetchCategories() async {
      

                try {

              final response = await supabase.from('category').select();

              if(response == null || response.isEmpty ) {


                print( response);
                return [];
              }
              else {
                  print(response);

                   final data = response;
    return data.map((e) => Category.fromMap(e as Map<String, dynamic>)).toList();

                  
              }

                }
                catch(e) {
                  print(e);
                  return [];
                }



        }
}