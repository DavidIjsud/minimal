enum Flavor { prod, dev }

class FlavorConfig {
  factory FlavorConfig({required Flavor flavor}) {
    _instance ??= FlavorConfig._internal(flavor: flavor);
    return _instance!;
  }

  FlavorConfig._internal({required this.flavor});
  final Flavor flavor;
  static FlavorConfig? _instance;

  static Flavor get currentFlavor => _instance!.flavor;
}
