import 'package:flutter/material.dart';

class WeatherSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const WeatherSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  State<WeatherSearchBar> createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<WeatherSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final city = _controller.text.trim();
    if (city.isNotEmpty) {
      widget.onSearch(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: '都市名を入力',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _handleSearch(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _handleSearch,
            ),
          ],
        ),
      ),
    );
  }
}
