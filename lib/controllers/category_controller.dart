import 'package:flutter/material.dart';

import '../main.dart';


class CategoryController {



        Future<List> fetchCategories() async {
      
              final response = await supabase.from('category').select();

              if(response == null || response.isEmpty ) {


                print( response);
                return [];
              }
              else {
                  print(response);
      return response;

                  
              }


        }
}