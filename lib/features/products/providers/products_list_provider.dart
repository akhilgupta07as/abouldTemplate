import 'package:abould_ada/modules/api_integration/di/api_providers.dart';
import 'package:abould_ada/modules/api_integration/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsListState {
  const ProductsListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.error,
    this.page = 0,
    this.hasMore = true,
    this.searchQuery = '',
  });

  final List<ProductModel> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;
  final String? error;
  final int page;
  final bool hasMore;
  final String searchQuery;

  bool get showFullShimmer => isLoading && items.isEmpty;

  ProductsListState copyWith({
    List<ProductModel>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    String? error,
    int? page,
    bool? hasMore,
    String? searchQuery,
    bool clearError = false,
  }) {
    return ProductsListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: clearError ? null : (error ?? this.error),
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ProductsListNotifier extends StateNotifier<ProductsListState> {
  ProductsListNotifier(this._ref) : super(const ProductsListState()) {
    loadInitial();
  }

  final Ref _ref;
  static const _pageSize = 10;

  Future<void> loadInitial() async {
    await _loadFirstPage(searchQuery: state.searchQuery);
  }

  Future<void> search(String query) async {
    await _loadFirstPage(searchQuery: query);
  }

  Future<void> _loadFirstPage({required String searchQuery}) async {
    final cache = _ref.read(productsCacheProvider);
    final cached = cache.get(searchQuery);

    if (cached != null && cached.items.isNotEmpty) {
      state = state.copyWith(
        searchQuery: searchQuery,
        items: cached.items,
        page: cached.page,
        hasMore: cached.hasMore,
        isLoading: false,
        isRefreshing: true,
        clearError: true,
      );
      await _fetch(page: 0, append: false, searchQuery: searchQuery);
      return;
    }

    state = state.copyWith(
      searchQuery: searchQuery,
      isLoading: true,
      isRefreshing: false,
      clearError: true,
      page: 0,
      items: [],
    );
    await _fetch(page: 0, append: false, searchQuery: searchQuery);
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;
    state = state.copyWith(isLoadingMore: true, clearError: true);
    await _fetch(
      page: state.page + 1,
      append: true,
      searchQuery: state.searchQuery,
    );
  }

  Future<void> _fetch({
    required int page,
    required bool append,
    required String searchQuery,
  }) async {
    try {
      final repo = _ref.read(productsRepositoryProvider);
      final result = await repo.getProducts(
        page: page,
        limit: _pageSize,
        searchQuery: searchQuery.isEmpty ? null : searchQuery,
      );
      final merged = append ? [...state.items, ...result.items] : result.items;

      _ref.read(productsCacheProvider).save(
            searchQuery: searchQuery,
            items: merged,
            page: page,
            hasMore: result.hasMore,
          );

      state = state.copyWith(
        items: merged,
        page: page,
        hasMore: result.hasMore,
        isLoading: false,
        isLoadingMore: false,
        isRefreshing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        isRefreshing: false,
        error: e.toString(),
      );
    }
  }
}

final productsListProvider =
    StateNotifierProvider<ProductsListNotifier, ProductsListState>(
  ProductsListNotifier.new,
);
