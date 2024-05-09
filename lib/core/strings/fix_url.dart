
class FixUrl {
  static String fixAvatarImage(String? image) {
    if (image == null) return '';
    if(image.startsWith('http'))return image;
    final String link = "http://92.205.22.218:44311/Images/$image";
    return link;
  }
}
