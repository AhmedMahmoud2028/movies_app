import 'package:flutter/material.dart';
import 'package:movies_app/core/modules/widgets/app_text_form_field.dart';

import '../../../configuration/gen/assets.gen.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 24,),
            AppTextFormField(hintText: "Search", prefixIcon: Assets.icons.searchIcon.svg(),controller: _searchController,),
          ],
        ),
      ),
    );
  }
}
