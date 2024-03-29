import 'package:flutter/material.dart';
import 'package:movies_app/BrowseTab/selectedcategorymovies/selectedcategorymovies.dart';
import 'package:movies_app/responses/CategoriesResponse.dart';

class SingleCategoryDesign extends StatelessWidget {
  //CategoriesDataModel categoriesDataModel;
  Genres category;

  SingleCategoryDesign({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SelectedCategoryMoviesScreen.routeName,
            arguments: category);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(
            'assets/images/clips.JPG',
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.fill,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.5,
            color: Color(0x93525151),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  )),
              child: Text(
                category.name ?? '',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
