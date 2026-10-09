import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../../navigation/app_routes.dart';
import '../../../repositories/home_repository.dart';
import '../../../repositories/product_repository.dart';
import '../../home/dialogs/image_search_dialog.dart';
import '../../home/dialogs/voice_search_dialog.dart';
import '../../home/widgets/custom_bottom_nav.dart';
import '../widgets/ai_search_header.dart';
import '../widgets/ai_search_hero_box.dart';
import '../widgets/natural_search_examples.dart';
import '../widgets/popular_searches_section.dart';
import '../widgets/quick_search_chips_section.dart';
import '../widgets/recent_searches_section.dart';
import '../widgets/search_category_shortcuts.dart';
import '../widgets/search_results_state_view.dart';

/// SCREEN 08 — QUCZO AI SEARCH SCREEN (PART A + PART B COMPLETE)
///
/// Features Part B Complete Implementation:
/// - Initial scroll position enforced at 0.0 top of screen
/// - Top Compact Header with Search Location ("Searching near Anna Nagar, Chennai")
/// - Primary AI Product Search Hero Box with Text Input, Mic (🎙), Camera (📷), Clear (X), & Selected Image Badge
/// - Search Submission with Validation, State Management (idle, loading, empty, error, results)
/// - Backend Search Integration via HomeRepository matching products by query
/// - "Recent searches" Section with Clear All & individual removal
/// - "Popular searches" Section with diverse pastel category chips
/// - "Search naturally — try these queries" Intent Examples
/// - "Try searching for" Quick Suggestion Chips
/// - "Explore products" Category Shortcuts Carousel (14 marketplace categories)
/// - Polished Search State Views (Finding products nearby..., No products found, Retry on error)
/// - 5-Item Bottom Navigation Bar (Search tab highlighted in Green, index 1)
/// - 5-Language Global Localization (English, Tamil, Telugu, Kannada, Hindi)
class AiSearchScreen extends StatefulWidget {
  const AiSearchScreen({super.key});

  @override
  State<AiSearchScreen> createState() => _AiSearchScreenState();
}

class _AiSearchScreenState extends State<AiSearchScreen> {
  final HomeRepository _repository = HomeRepository();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<CategoryModel> _categories = [];
  List<ProductModel> _searchResults = [];

  List<String> _recentSearches = [
    'Surf Excel 2kg',
    'Phone Charger',
    'LED Bulb',
    'Sona Masoori Rice',
  ];

  SearchStatus _searchStatus = SearchStatus.idle;
  String _activeQuery = '';
  String? _selectedImageName;

  bool _isLoadingCategories = true;
  bool _isListening = false;
  int _currentNavIndex = 1; // Search tab selected
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadInitialData();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    final query = _searchController.text.trim();
    
    if (query.isEmpty) {
      if (_searchStatus != SearchStatus.idle) {
        setState(() {
          _activeQuery = '';
          _searchStatus = SearchStatus.idle;
          _searchResults = [];
        });
      }
      return;
    }

    // Only run if the query actually changed
    if (query != _activeQuery) {
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _activeQuery = query;
        _executeSearch(query);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    try {
      final categories = await _repository.getCategories();
      final popular = await _repository.getPopularProducts();
      final nearby = await _repository.getNearbyProducts();
      final deals = await _repository.getPriceComparisonDeals();

      final Map<String, ProductModel> uniqueProducts = {};
      for (final p in [...popular, ...nearby, ...deals]) {
        uniqueProducts[p.id] = p;
      }

      if (mounted) {
        setState(() {
          _categories = categories;
          _isLoadingCategories = false;
        });

        // Ensure Screen 08 opens at the TOP (Scroll offset 0.0)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(0.0);
          }
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoadingCategories = false;
        });
      }
    }
  }

  void _handleNavigation(String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  Future<void> _triggerVoiceSearch() async {
    setState(() {
      _isListening = true;
    });

    final query = await VoiceSearchDialog.show(context);

    if (mounted) {
      setState(() {
        _isListening = false;
      });
      if (query != null && query.isNotEmpty) {
        _onQuerySubmitted(query);
      }
    }
  }

  Future<void> _triggerImageSearch() async {
    final sampleResult = await ImageSearchDialog.show(context);
    if (sampleResult != null && sampleResult.isNotEmpty && mounted) {
      setState(() {
        _selectedImageName = sampleResult;
      });
      _onQuerySubmitted(sampleResult);
    }
  }

  void _onQuerySubmitted(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    _searchController.text = trimmed;
    _activeQuery = trimmed;

    // Add to recent searches if not present
    if (!_recentSearches.contains(trimmed)) {
      setState(() {
        _recentSearches.insert(0, trimmed);
        if (_recentSearches.length > 8) {
          _recentSearches = _recentSearches.sublist(0, 8);
        }
      });
    }

    _executeSearch(trimmed);
  }

  Future<void> _executeSearch(String query) async {
    setState(() {
      _searchStatus = SearchStatus.loading;
    });

    if (!mounted) return;

    try {
      final repo = ProductRepository();
      final matches = await repo.searchProducts(query);

      if (!mounted) return;
      setState(() {
        _searchResults = matches;
        _searchStatus = matches.isNotEmpty ? SearchStatus.results : SearchStatus.empty;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _searchStatus = SearchStatus.error;
        });
      }
    }
  }

  void _onClearSearch() {
    setState(() {
      _searchController.clear();
      _activeQuery = '';
      _selectedImageName = null;
      _searchStatus = SearchStatus.idle;
      _searchResults = [];
    });
  }

  void _removeRecentSearch(String query) {
    setState(() {
      _recentSearches.remove(query);
    });
  }

  void _clearAllRecentSearches() {
    setState(() {
      _recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentSearchLocation = context.tr('defaultLocation');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header: QUCZO Logo + Location Selector + Back Option
            AiSearchHeader(
              locationText: currentSearchLocation,
              onLocationTap: () => _handleNavigation(AppRoutes.locationSelection),
              onBackTap: () => Navigator.pop(context),
            ),

            // Main Scrollable AI Search Content
            Expanded(
              child: _isLoadingCategories
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.green,
                        strokeWidth: 3,
                      ),
                    )
                  : SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),

                          // 2. Primary AI Search Hero Card (Text, Clear X, Mic 🎙, Camera 📷)
                          AiSearchHeroBox(
                            controller: _searchController,
                            onSubmitted: _onQuerySubmitted,
                            onVoiceTap: _triggerVoiceSearch,
                            onCameraTap: _triggerImageSearch,
                            onClearTap: _onClearSearch,
                            selectedImageName: _selectedImageName,
                            onRemoveSelectedImage: () {
                              setState(() {
                                _selectedImageName = null;
                              });
                            },
                            isListening: _isListening,
                          ),

                          // 3. Search Results or State View (when active query submitted)
                          if (_searchStatus != SearchStatus.idle) ...[
                            SearchResultsStateView(
                              status: _searchStatus,
                              products: _searchResults,
                              activeQuery: _activeQuery,
                              onRetry: () => _onQuerySubmitted(_activeQuery),
                              onProductTap: (product) {
                                Navigator.pushNamed(
                                  context, 
                                  AppRoutes.productDetails, 
                                  arguments: product,
                                );
                              },
                            ),
                          ],

                          // 4. Discovery Sections (Shown when idle or alongside search)
                          if (_searchStatus == SearchStatus.idle || _searchStatus == SearchStatus.results) ...[
                            const SizedBox(height: 8),

                            // Natural Language Intent Prompts
                            NaturalSearchExamples(
                              onQueryTap: _onQuerySubmitted,
                            ),

                            const SizedBox(height: 12),

                            // Recent Searches (History)
                            RecentSearchesSection(
                              recentSearches: _recentSearches,
                              onQueryTap: _onQuerySubmitted,
                              onRemoveItem: _removeRecentSearch,
                              onClearAll: _clearAllRecentSearches,
                            ),

                            const SizedBox(height: 12),

                            // Popular Searches
                            PopularSearchesSection(
                              onQueryTap: _onQuerySubmitted,
                            ),

                            const SizedBox(height: 16),

                            // "Try searching for" Quick Suggestion Chips
                            QuickSearchChipsSection(
                              onChipTap: _onQuerySubmitted,
                            ),

                            const SizedBox(height: 20),

                            // "Explore products" Category Shortcuts Carousel
                            SearchCategoryShortcuts(
                              categories: _categories,
                              onCategoryTap: (category) {
                                _onQuerySubmitted(context.tr(category.titleKey));
                              },
                            ),

                            const SizedBox(height: 32),
                          ],
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),

      // 5. Exactly 5-Item Bottom Navigation Bar (Search tab highlighted in Green, index 1)
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index == _currentNavIndex) return;

          setState(() {
            _currentNavIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
          } else if (index == 2) {
            _handleNavigation(AppRoutes.cart);
          } else if (index == 3) {
            _handleNavigation(AppRoutes.orders);
          } else if (index == 4) {
            _handleNavigation(AppRoutes.profile);
          }
        },
      ),
    );
  }
}
