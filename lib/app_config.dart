enum Flavor { free, paid }

class AppConfig {
  Flavor flavor = Flavor.free;
  String title = "";

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String title = "",
    Flavor flavor = Flavor.free,
  }) {
    return shared = AppConfig(flavor, title);
  }

  AppConfig(this.flavor, this.title);
}
