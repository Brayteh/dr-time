import 'dart:async';
import 'package:dr_time/data/drug_api_service.dart';
import 'package:flutter/material.dart';
import 'package:dr_time/domain/drug_info.dart'; // Import DrugInfo
import 'package:dr_time/screens/drug_detail_page.dart'; // Import DrugDetailPage
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  List<DrugInfo> _results = [];
  bool _isLoading = false;
  String? _errorMessage;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted && _searchController.text.isNotEmpty) {
        _performSearch();
      } else if (mounted) {
        // Clear results and error when search query is empty
        setState(() {
          _results = [];
          _isLoading = false;
          _errorMessage = null;
        });
      }
    });
  }

  void _performSearch() async {
    final apiService = context.read<DrugApiService>();
    setState(() {
      _isLoading = true;
      _errorMessage = null; // Clear previous errors
    });
    try {
      final results = await apiService.searchDrugs(_searchController.text);
      _results = results;
    } catch (e) {
      _errorMessage = "Failed to load drugs: $e";
      _results = []; // Clear results on error
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("images/loupe.png"),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text("Search Online", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search for Aspirin, Ibuprofen...",
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        )
                      : null,
                ),
              ),
            ),
            Expanded(child: _buildResults()),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)));
    }
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_results.isEmpty && _searchController.text.isNotEmpty) {
      return const Center(child: Text("No results found."));
    }
    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final drug = _results[index];
        return ListTile(
          title: Text(drug.brandName),
          subtitle: Text(drug.genericName),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DrugDetailPage(drugInfo: drug)),
            );
          },
        );
      },
    );
  }
}