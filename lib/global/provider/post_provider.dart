import 'package:dongnesosik/global/provider/parent_provider.dart';

class PostProvider extends ParentProvider {
  String reviewTarget = '';

  void setReviewTarget(String _reviewTarget) {
    reviewTarget = _reviewTarget;
    notifyListeners();
  }
}
