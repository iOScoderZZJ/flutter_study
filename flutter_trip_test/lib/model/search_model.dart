
///搜索模型
class SearchModel{
  final List<SearchItem> data;

  SearchModel({this.data});

  factory SearchModel.fromjson(Map<String, dynamic> json){
    var datajson = json['data'] as List;
    List<SearchItem> data = datajson.map((i) => SearchItem.fromJson(i)).toList();
    return SearchModel(data: data);
  }
}


//String word	String	Nullable //xx酒店
//String type	String	Nullable //hotel
//String price	String	Nullable //实时计价
//String star	String	Nullable //豪华型
//String zonename	String	Nullable //虹桥
//String districtname	String	Nullable //上海
//String url	String	NonNull

class SearchItem {
  final String word;
  final String type;
  final String price;
  final String star;
  final String zonename;
  final String districtname;
  final String url;

  SearchItem({this.word,this.type,this.price,this.star,this.zonename,this.districtname,this.url});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      word: json['word'],
      type: json['type'],
      price: json['price'],
      star: json['star'],
      zonename: json['zonename'],
      districtname: json['districtname'],
      url: json['url'],
    );
  }
}
