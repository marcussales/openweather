enum CitiesEnum {
  silverstoneUK,
  saoPauloBR,
  melbourneAU,
  monteCarloMC,
}

extension CitiesExtension on CitiesEnum {
  String get name {
    switch (this) {
      case CitiesEnum.silverstoneUK:
        return "Silverstone, UK";
      case CitiesEnum.saoPauloBR:
        return "São Paulo, Brasil";
      case CitiesEnum.melbourneAU:
        return "Melbourne, Australia";
      case CitiesEnum.monteCarloMC:
        return "Monte Carlo";
      default:
        return "Unknown";
    }
  }

  String get icon {
    switch (this) {
      case CitiesEnum.silverstoneUK:
        return 'assets/images/ukraine.png';
      case CitiesEnum.saoPauloBR:
        return 'assets/images/brazil.png';
      case CitiesEnum.melbourneAU:
        return 'assets/images/australia.png';
      case CitiesEnum.monteCarloMC:
        return 'assets/images/monaco.png';
      default:
        return 'assets/images/circulo.png';
    }
  }
}

mixin CityDataHelper {
  static String iconByDescription(String? city) {
    switch (city) {
      case "Silverstone, UK":
        return 'assets/images/ukraine.png';
      case "São Paulo, Brasil":
        return 'assets/images/brazil.png';
      case "Melbourne, Australia":
        return 'assets/images/australia.png';
      case "Monte Carlo":
        return 'assets/images/monaco.png';
      default:
        return 'assets/images/circulo.png';
    }
  }

  static List<String> get allCities => CitiesEnum.values.map((city) => city.name).toList();
}
