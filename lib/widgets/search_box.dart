import 'package:blocecommerce/blocs/search/search_bloc.dart';
import 'package:blocecommerce/models/category_model.dart';
import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBox extends StatelessWidget {
  final Category? category;
  const SearchBox({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (state is SearchLoaded) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 10,
              right: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Search for a product",
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.all(10),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          context.read<SearchBloc>().add(SearchProduct(
                                productName: value,
                                category: category,
                              ));
                        },
                      ),
                    ),
                  ],
                ),
                state.products.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ProductCard.catalog(
                              product: state.products[index],
                              widthFactor: 1.1,
                            ),
                          );
                        })
                    : const SizedBox(),
              ],
            ),
          );
        } else {
          return Text("Something is wrong");
        }
      },
    );
  }
}
