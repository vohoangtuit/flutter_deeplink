class DeepLinkModel{
  String? link ;
  String? tourId ;
  String? utm_source;
  String? rk ;
  String? atnct1;
  String? atnct2;
  String? atnct3;

  DeepLinkModel({this.link,this.tourId, this.utm_source, this.rk, this.atnct1, this.atnct2,
      this.atnct3});

  @override
  String toString() {
    return 'DeepLinkModel{link: $link,tourId:$tourId, utm_source: $utm_source, rk: $rk, atnct1: $atnct1, atnct2: $atnct2, atnct3: $atnct3}';
  }
}