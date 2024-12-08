
import 'package:miles_sample/utils/constants.dart';

mixin class ProviderHelperClass {
  LoaderState loaderState = LoaderState.initial;
  int apiCallCount = 0;
  bool btnLoader = false;
  void pageInit() {}
  void pageDispose() {}
  void updateApiCallCount() {}
  void updateLoadState(LoaderState state){}
  void updateBtnLoader(bool value) {}
}

