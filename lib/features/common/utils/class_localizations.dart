class Localization {
  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return "English";
      case 'id':
      default:
        return "Indonesia";
    }
  }
}
