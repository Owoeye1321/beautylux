class LikeModel {
  String company_id;
  String user_id;
  LikeModel({required this.company_id, required this.user_id});
  static List<LikeModel> fromJsonList(Map<String, dynamic> data) {
    List<LikeModel> likes = [];
    for (Map<String, dynamic> data in data['data']) {
      LikeModel like = LikeModel(company_id: data['provider_id'], user_id: data['user_id']);
      likes.add(like);
    }
    return likes;
  }
}
