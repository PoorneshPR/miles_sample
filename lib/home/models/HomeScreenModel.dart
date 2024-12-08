class HomeScreenDataModel {
  List<HomeScreenResponseData>? homeScreenResponseData;

  HomeScreenDataModel({this.homeScreenResponseData});

  HomeScreenDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      homeScreenResponseData = <HomeScreenResponseData>[];
      json['data'].forEach((v) {
        homeScreenResponseData!.add(HomeScreenResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.homeScreenResponseData != null) {
      data['data'] = this.homeScreenResponseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeScreenResponseData {
  String? id;
  String? blockType;
  String? name;
  String? heading;
  int? position;
  int? count;
  bool? active;
  String? createdAt;
  String? updatedAt;
  String? vertical;
  String? createdBy;
  String? modifiedBy;
  List<HomeScreenDataPosts>? homeScreenDataPosts;

  HomeScreenResponseData(
      {this.id,
        this.blockType,
        this.name,
        this.heading,
        this.position,
        this.count,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.vertical,
        this.createdBy,
        this.modifiedBy,
        this.homeScreenDataPosts});

  HomeScreenResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blockType = json['block_type'];
    name = json['name'];
    heading = json['heading'];
    position = json['position'];
    count = json['count'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vertical = json['vertical'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    if (json['posts'] != null) {
      homeScreenDataPosts = <HomeScreenDataPosts>[];
      json['posts'].forEach((v) {
        homeScreenDataPosts!.add(HomeScreenDataPosts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['block_type'] = blockType;
    data['name'] = name;
    data['heading'] = heading;
    data['position'] = position;
    data['count'] = count;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['vertical'] = vertical;
    data['created_by'] = createdBy;
    data['modified_by'] = modifiedBy;
    if (homeScreenDataPosts != null) {
      data['posts'] = homeScreenDataPosts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeScreenDataPosts {
  String? id;
  List<Files>? files;
  bool? likedByMe;
  String? title;
  String? postType;
  String? description;
  String? metadata;
  String? fullVideoUrl;
  String? blogUrl;
  bool? active;
  bool? featured;
  int? priority;
  int? likes;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? layout;
  String? persona;
  String? modifiedBy;

  HomeScreenDataPosts(
      {this.id,
        this.files,
        this.likedByMe,
        this.title,
        this.postType,
        this.description,
        this.metadata,
        this.fullVideoUrl,
        this.blogUrl,
        this.active,
        this.featured,
        this.priority,
        this.likes,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.layout,
        this.persona,
        this.modifiedBy});

  HomeScreenDataPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    likedByMe = json['liked_by_me'];
    title = json['title'];
    postType = json['post_type'];
    description = json['description'];
    metadata = json['metadata'];
    fullVideoUrl = json['full_video_url'];
    blogUrl = json['blog_url'];
    active = json['active'];
    featured = json['featured'];
    priority = json['priority'];
    likes = json['likes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    layout = json['layout'];
    persona = json['persona'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    data['liked_by_me'] = likedByMe;
    data['title'] = title;
    data['post_type'] = postType;
    data['description'] = description;
    data['metadata'] = metadata;
    data['full_video_url'] = fullVideoUrl;
    data['blog_url'] = blogUrl;
    data['active'] = active;
    data['featured'] = featured;
    data['priority'] = priority;
    data['likes'] = likes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['layout'] = layout;
    data['persona'] = persona;
    data['modified_by'] = modifiedBy;
    return data;
  }
}

class Files {
  String? id;
  String? mediaType;
  String? videoUrl;
  String? thumbnail;
  String? imagePath;
  int? mediaOrder;
  String? ratio;
  bool? active;
  String? post;

  Files({this.id,
    this.mediaType,
    this.videoUrl,
    this.thumbnail,
    this.imagePath,
    this.mediaOrder,
    this.ratio,
    this.active,
    this.post});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    videoUrl = json['video_url'];
    thumbnail = json['thumbnail'];
    imagePath = json['image_path'];
    mediaOrder = json['media_order'];
    ratio = json['ratio'];
    active = json['active'];
    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['media_type'] = mediaType;
    data['video_url'] = videoUrl;
    data['thumbnail'] = thumbnail;
    data['image_path'] = imagePath;
    data['media_order'] = mediaOrder;
    data['ratio'] = ratio;
    data['active'] = active;
    data['post'] = post;
    return data;
  }
}