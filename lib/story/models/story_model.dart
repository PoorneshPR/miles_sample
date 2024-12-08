class StoryModel {
  String? message;
  List<StoryListData>? data;

  StoryModel({this.message, this.data});

  StoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <StoryListData>[];
      json['data'].forEach((v) {
        data!.add(StoryListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoryListData {
  String? id;
  bool? likedByMe;
  String? firstName;
  String? lastName;
  String? description;
  String? imageUrl;
  String? videoUrl;
  String? fullVideoUrl;
  int? likes;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? modifiedBy;
  bool? watched;

  StoryListData(
      {this.id,
        this.likedByMe,
        this.firstName,
        this.lastName,
        this.description,
        this.imageUrl,
        this.videoUrl,
        this.fullVideoUrl,
        this.likes,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.modifiedBy,
        this.watched});

  StoryListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    likedByMe = json['liked_by_me'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    description = json['description'];
    imageUrl = json['image_url'];
    videoUrl = json['video_url'];
    fullVideoUrl = json['full_video_url']??"";
    likes = json['likes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    watched = json['watched'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['liked_by_me'] = this.likedByMe;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['video_url'] = this.videoUrl;
    data['full_video_url'] = this.fullVideoUrl;
    data['likes'] = this.likes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['watched'] = this.watched;
    return data;
  }
}