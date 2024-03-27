enum Flavor { free, paid }

class AppConfig {
  Flavor flavor = Flavor.free;

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    Flavor flavor = Flavor.free,
  }) {
    return shared = AppConfig(flavor);
  }

  AppConfig(this.flavor);
}
