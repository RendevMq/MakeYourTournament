import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/presentation/providers/category_filter_profile_provider.dart';

class FilterChipProfileWidget extends StatelessWidget {
  String thisCategory;
  FilterChipProfileWidget({super.key, required this.thisCategory});

  @override
  Widget build(BuildContext context) {
    final _categoryProvider = context.watch<CategoryFilterProfileProvider>();

    return FilterChip(
      selected:
          _categoryProvider.categorySelected == thisCategory, //true o false
      padding: const EdgeInsets.symmetric(horizontal: 2),
      backgroundColor: kBrandPrimaryColor,
      label: Text(thisCategory),

      selectedColor: categoryColor[
          _categoryProvider.categorySelected], //cambiar color al seleccionar
      checkmarkColor: Colors.white, //cambiar el color del check
      labelStyle: TextStyle(
          color: _categoryProvider.categorySelected == thisCategory
              ? Colors.white
              : kBrandThirdColor), //cambiar color de texto
      onSelected: (bool value) {
        _categoryProvider.changeCategory(thisCategory);
        // _categoryProvider.categorySelected = thisCategory;
        // setState(() {});
      },
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: _categoryProvider.categorySelected == thisCategory
                ? Colors.transparent
                : kBrandThirdColor,
          ),
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
