import 'package:flutter/material.dart';
import 'package:poetry_app/model/poet.dart';
import 'package:poetry_app/model/poetry.dart';
import 'package:poetry_app/model/poets.dart';
import 'package:poetry_app/screens/poetryscreen.dart';

class Mydelegate extends SearchDelegate {
  final List<Poet> data;
  Mydelegate({required this.data});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.close,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = data.where((element) =>
        element.poetname.toLowerCase().contains(query.toLowerCase()));
    return ListView(
      children: results
          .map((result) => ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                onTap: () {
                  close(context, result);
                  query = result.poetname;
                  showResults(context);
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: PoetryScreen(
                            image: result.imageurl,
                            poetry: getPoetry(
                              result.poetname,
                            ),
                            title: result.poetname),
                      );
                    },
                  ));
                },
                title: Text(result.poetname),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    result.imageurl,
                  ),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = data.where(
      (element) => element.poetname.toLowerCase().startsWith(
            query.toLowerCase(),
          ),
    );
    return ListView(
      children: suggestions
          .map(
            (suggestion) => ListTile(
              contentPadding: const EdgeInsets.all(10.0),
              onTap: () {
                query = suggestion.poetname;
                showResults(context);
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: PoetryScreen(
                          image: suggestion.imageurl,
                          poetry: getPoetry(
                            suggestion.poetname,
                          ),
                          title: suggestion.poetname),
                    );
                  },
                ));
              },
              title: Text(suggestion.poetname),
              leading: Hero(
                tag: suggestion.poetname,
                child: CircleAvatar(
                  backgroundImage: AssetImage(suggestion.imageurl),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  List<Poetry> getPoetry(String name) {
    if (name == 'Ahmad Faraz') {
      return Poets.faraz;
    } else if (name == 'Parveen Shaakir') {
      return Poets.parveen;
    } else if (name == 'John Elia') {
      return Poets.john;
    } else if (name == 'Tehzeeb Haafi') {
      return Poets.haafi;
    } else if (name == 'Ali Zaryoun') {
      return Poets.ali;
    } else if (name == 'Wasi Shah') {
      return Poets.wasi;
    } else {
      return [];
    }
  }
}
