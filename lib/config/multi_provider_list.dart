import 'package:miles_sample/home/providers/home_screen_provider.dart';
import 'package:miles_sample/story/providers/story_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultiProviderList{
  static List<SingleChildWidget> providerList = [
    ChangeNotifierProvider(create: (_) => StoryProvider()),
    ChangeNotifierProvider(create: (_) =>HomeScreenProvider()),

  ];

}