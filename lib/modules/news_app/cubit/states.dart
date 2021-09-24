abstract class newsStates {}

class newsInitialState extends newsStates {}

class newsChangeBottomNavBarState extends newsStates {}

class newsLoadingState extends newsStates {}

class NewsGetSportsLoadingState extends newsStates {}

class NewsGetSportsSuccessState extends newsStates {}

class NewsGetSportsErrorState extends newsStates
{
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends newsStates {}

class NewsGetScienceSuccessState extends newsStates {}

class NewsGetScienceErrorState extends newsStates
{
  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsGetBusinessLoadingState extends newsStates {}

class NewsGetBusinessSuccessState extends newsStates {}

class NewsGetBusinessErrorState extends newsStates
{
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSearchLoadingState extends newsStates {}

class NewsGetSearchSuccessState extends newsStates {}

class NewsGetSearchErrorState extends newsStates
{
  final String error;

  NewsGetSearchErrorState(this.error);
}
