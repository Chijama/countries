import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: TextField(
          //controller: TextEditingController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              fillColor: Colors.white12,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(width: 0.8)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  width: 0.8,
                  //color: Theme.of(context).primaryColor,
                ),
              ),
              hintText: "Search Countries",
              //hintStyle: GoogleFonts.ax
              prefixIcon: const Icon(
                Icons.search,
                size: 30,
              ),
              suffixIcon:
                  IconButton(icon: const Icon(Icons.clear), onPressed: () {})),
        ),
      ),
    );
  }
}
