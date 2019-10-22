class Video{

  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({this.id, this.title, this.thumb, this.channel});

  factory Video.fromJson(Map<String, dynamic> json){
    if(json.containsKey("id")){
      return Video(
          id: json["id"]["videoId"],
          channel: json["snippet"]["channelTitle"],
          thumb: json["snippet"]["thumbnails"]["high"]["url"],
          title: json["snippet"]["title"]
      );
    }else{
      return Video(
        id: json["videoId"],
        title: json["title"],
        thumb: json["thumb"],
        channel: json["channel"]
      );
    }
  }

  Map<String, dynamic> toJson(){
    return {
      "videoId" : id,
      "title" : title,
      "thumb" : thumb,
      "channel": channel
    };
  }
}