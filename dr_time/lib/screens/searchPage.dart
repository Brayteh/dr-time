import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("images/loupe.png"),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text("Search", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text("Name of medicament", style: TextStyle(fontSize: 22),),
          ),
          SizedBox(height: 8,),
          Padding(padding: EdgeInsetsGeometry.all(16),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(prefixIcon: Icon(Icons.search),
            hintText: "Search here",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.black, ),
            ),
              enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.black, ),
            ),
            
            
            ),
            ),
          ),
        ],
      ),
    );
  }
}