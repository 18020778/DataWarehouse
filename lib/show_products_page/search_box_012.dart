import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key key, this.text}) : super(key: key);

  final String text;
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  static const historyLength = 6;
  List<String> _searchHistory = ["linh","hoai","tu", "diu", "bao", "linh khiem"];

  List<String> filterSearchTerms({
    String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  String selectedTerm;
  List<String> filteredSearchHistory;

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      automaticallyImplyBackButton: false,
      width: MediaQuery.of(context).size.width,
            borderRadius: BorderRadius.circular(50),
            //margins:
               // EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 15),
           // padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
            controller: controller,
            transition: CircularFloatingSearchBarTransition(),
            physics: BouncingScrollPhysics(),
            title: Text(
              selectedTerm ?? widget.text,
              style: TextStyle(color: Colors.black54, fontSize: 20),
            ),
            actions: [
              FloatingSearchBarAction.searchToClear(),
            ],
            onQueryChanged: (query) {
              setState(() {
                filteredSearchHistory = filterSearchTerms(filter: query);
              });
            },
            onSubmitted: (query) {
              setState(() {
                addSearchTerm(query);
                selectedTerm = query;
              });
              controller.close();
            },
            builder: (context, transition) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                      color: Colors.white,
                      elevation: 4,
                      child: Builder(builder: (context) {
                        if (filteredSearchHistory.isEmpty &&
                            controller.query.isEmpty) {
                          return Container(
                              height: 56,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text("Bắt đầu tìm kiếm",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.caption));
                        } else if (filteredSearchHistory.isEmpty) {
                          return ListTile(
                              title: Text(controller.query),
                              leading: const Icon(Icons.search),
                              onTap: () {
                                setState(() {
                                  addSearchTerm(controller.query);
                                  selectedTerm = controller.query;
                                });
                                controller.close();
                              });
                        } else {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: filteredSearchHistory
                                .map((term) => ListTile(
                                      title: Text(
                                        term,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      leading: const Icon(Icons.history),
                                      trailing: IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            setState(() {
                                              deleteSearchTerm(term);
                                            });
                                          }),
                                      onTap: () {
                                        setState(() {
                                          putSearchTermFirst(term);
                                          selectedTerm = term;
                                        });
                                        controller.close();
                                      },
                                    ))
                                .toList(),
                          );
                        }
                      })));
            });
  }
}

/*class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({Key key, this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
            ),
            Text("Bắt đầu tìm kiếm",
                style: Theme.of(context).textTheme.headline6)
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);
    return Container(
        decoration: BoxDecoration(color: Color(4291751385)),
      child: ListView(
      padding: EdgeInsets.only(top: 60),
      children: List.generate(
          1,
          (index) => ListTile(
                title: Text('$searchTerm'),
                //subtitle: Text(index.toString()),
              )),
    ));
  }
}*/
