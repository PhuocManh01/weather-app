abstract class MoreState {}

class MoreInitialState extends MoreState {}
class MoreLoadingState extends MoreState {}

class NavigateToProfileState extends MoreState {}
class NavigateToFaqState extends MoreState {}
class NavigateToContactUsState extends MoreState {}

class MoreFailureState extends MoreState {
  final String errorMessage;
  MoreFailureState(this.errorMessage);
}