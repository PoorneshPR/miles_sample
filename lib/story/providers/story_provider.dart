import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miles_sample/generated/assets.dart';
import 'package:miles_sample/story/models/story_model.dart';
import 'package:miles_sample/utils/constants.dart';
import 'package:miles_sample/utils/provider_helper_class.dart';

class StoryProvider extends ChangeNotifier with ProviderHelperClass{
StoryModel? storyModel;

  getViewStory()async{

    updateLoadState(LoaderState.loading);
    try{
    final String response = await rootBundle.loadString(Assets.dataJsonTestimonials);
    final data = await json.decode(response);
   StoryModel storyModelResponse = StoryModel.fromJson(data);
    print(storyModelResponse.data);
    if((storyModelResponse.data??[]).isNotEmpty){
      storyModel=storyModelResponse;
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
      storyModel?.data?[index].likedByMe=isLiked;
      storyModel?.data?[index].likes= ( storyModel?.data?[index].likes??0)+1;
     print(storyModel?.data?[index].likes);
    }else{
      storyModel?.data?[index].likedByMe=isLiked;
      storyModel?.data?[index].likes= ( storyModel?.data?[index].likes??0)-1;
      print(storyModel?.data?[index].likes);
    }
    notifyListeners();
  }
  storyAlreadyWatched({required bool isWatched,required int index,}){
    if(isWatched){
      storyModel?.data?[index].watched=isWatched;

    }else{
      storyModel?.data?[index].watched=isWatched;

    }
    notifyListeners();
  }
  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }


}