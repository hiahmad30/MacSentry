import 'dart:io';

class ServerListModel {
  final String country;
  final String url;
  final String fileUrl;
  final File file;

  ServerListModel(this.country, this.url, this.file, this.fileUrl);
}
