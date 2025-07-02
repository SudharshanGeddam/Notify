import 'package:flutter/material.dart';

class FilterListView extends StatefulWidget {
  const FilterListView({
    super.key,
    required this.filters,
    required this.onFilterSelected,
  });

  final List<String> filters;
  final ValueChanged<String> onFilterSelected;

  @override
  State<FilterListView> createState() => _FilterListViewState();
}

class _FilterListViewState extends State<FilterListView> {
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    // Initialize the selected filter to the first filter in the list
    if (widget.filters.isNotEmpty) {
      selectedFilter = widget.filters[0];
    } else {
      selectedFilter = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: widget.filters.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          final filter = widget.filters[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
                widget.onFilterSelected(filter);
              },
              child: Chip(
                label: Text(filter),
                backgroundColor: selectedFilter == filter
                    ? Color.fromRGBO(2, 129, 255, 1)
                    : Colors.white,
                side: BorderSide(color: Color.fromRGBO(212, 219, 225, 1)),
                labelStyle: TextStyle(fontSize: 14.0),
                padding: const EdgeInsets.all(8.0),
               
              ),
            ),
          );
        },
      ),
    );
  }
}
