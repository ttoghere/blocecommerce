import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocecommerce/blocs/product/product_bloc.dart';
import 'package:blocecommerce/models/category_model.dart';
import 'package:blocecommerce/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductBloc _productBloc;
  StreamSubscription? _productSubs;
  SearchBloc({required ProductBloc productBloc})
      : _productBloc = productBloc,
        super(SearchLoading()) {
    on<LoadSearch>(_onLoadSearch);
    on<SearchProduct>(_onSearchProduct);
    on<UpdateResults>(_onUpdateResults);
  }

  void _onLoadSearch(LoadSearch event, Emitter<SearchState> emit) {
    emit(const SearchLoaded());
  }

  void _onSearchProduct(SearchProduct event, Emitter<SearchState> emit) {
    List<Product> products = (_productBloc.state as ProductLoaded).products;
    if (event.category != null) {
      products = products
          .where((product) => product.category == event.category!.name)
          .toList();
    }
    if (event.productName.isNotEmpty) {
      List<Product> searchResults = products
          .where((product) => product.name
              .toLowerCase()
              .startsWith(event.productName.toLowerCase()))
          .toList();

      emit(SearchLoaded(products: searchResults));
    } else {
      emit(const SearchLoaded());
    }
  }

  void _onUpdateResults(UpdateResults event, Emitter<SearchState> emit) {}

  @override
  Future<void> close() {
    _productSubs!.cancel();
    return super.close();
  }
}
