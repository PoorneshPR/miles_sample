import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:miles_sample/generated/assets.dart';
import 'package:miles_sample/home/models/HomeScreenModel.dart';
import 'package:miles_sample/utils/constants.dart';
import 'package:miles_sample/utils/provider_helper_class.dart';

class HomeScreenProvider extends ChangeNotifier with ProviderHelperClass{
    HomeScreenDataModel? homeScreenDataModel;

  getHomeScreenData()async{
    updateLoadState(LoaderState.loading);
    try{
      final String response = await rootBundle.loadString(Assets.dataJsonHomepage);
      final data = await json.decode(response);
      HomeScreenDataModel homeScreenDataModelResponse = HomeScreenDataModel.fromJson(data);
      print(homeScreenDataModelResponse.homeScreenResponseData);
      if((homeScreenDataModelResponse.homeScreenResponseData??[]).isNotEmpty){
        homeScreenDataModel=homeScreenDataModelResponse;
        updateLoadState(LoaderState.loaded);
      }else{
        updateLoadState(LoaderState.noData);
      }}
    catch(e){
      updateLoadState(LoaderState.error);
    }

    notifyListeners();

  }




  gettingLike({required bool isLiked,required int index,}){
    if(isLiked){
    homeScreenDataModel
        ?.homeScreenResponseData?[1]
        .homeScreenDataPosts?[index].likedByMe=isLiked;
    homeScreenDataModel
        ?.homeScreenResponseData?[1]
        .homeScreenDataPosts?[index].likes= (  homeScreenDataModel
        ?.homeScreenResponseData?[1]
        .homeScreenDataPosts?[index].likes??0)+1;

    }else{
      homeScreenDataModel
          ?.homeScreenResponseData?[1]
          .homeScreenDataPosts?[index].likedByMe=isLiked;
      homeScreenDataModel
          ?.homeScreenResponseData?[1]
          .homeScreenDataPosts?[index].likes= (  homeScreenDataModel
          ?.homeScreenResponseData?[1]
          .homeScreenDataPosts?[index].likes??0)-1;

    }
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }

}