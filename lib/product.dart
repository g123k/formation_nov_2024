class Product {
  final String barcode;
  final String? name;
  final String? altName;
  final String? picture;
  final String? quantity;
  final List<String>? brands;
  final List<String>? manufacturingCountries;
  final ProductNutriscore? nutriScore;
  final ProductNovaScore? novaScore;
  final ProductEcoScore? ecoScore;
  final List<String>? ingredients;
  final List<String>? traces;
  final List<String>? allergens;
  final Map<String, String>? additives;
  final NutrientLevels? nutrientLevels;
  final NutritionFacts? nutritionFacts;
  final bool? ingredientsFromPalmOil;

  Product(
      {required this.barcode,
      this.name,
      this.altName,
      this.picture,
      this.quantity,
      this.brands,
      this.manufacturingCountries,
      this.nutriScore,
      this.novaScore,
      this.ecoScore,
      this.ingredients,
      this.traces,
      this.allergens,
      this.additives,
      this.nutrientLevels,
      this.nutritionFacts,
      this.ingredientsFromPalmOil});
}

class NutritionFacts {
  final String servingSize;
  final Nutriment? calories;
  final Nutriment? fat;
  final Nutriment? saturatedFat;
  final Nutriment? carbohydrate;
  final Nutriment? sugar;
  final Nutriment? fiber;
  final Nutriment? proteins;
  final Nutriment? sodium;
  final Nutriment? salt;
  final Nutriment? energy;

  NutritionFacts(
      {required this.servingSize,
      this.calories,
      this.fat,
      this.saturatedFat,
      this.carbohydrate,
      this.sugar,
      this.fiber,
      this.proteins,
      this.sodium,
      this.salt,
      this.energy});
}

class Nutriment {
  final String unit;
  final dynamic perServing;
  final dynamic per100g;

  Nutriment({required this.unit, this.perServing, this.per100g});
}

class NutrientLevels {
  final String? salt;
  final String? saturatedFat;
  final String? sugars;
  final String? fat;

  NutrientLevels({this.salt, this.saturatedFat, this.sugars, this.fat});
}

enum ProductNutriscore {
  A("a"),
  B("b"),
  C("c"),
  D("d"),
  E("e");

  final String letter;

  const ProductNutriscore(this.letter);
}

enum ProductNovaScore { Group1, Group2, Group3, Group4 }

enum ProductEcoScore { A, B, C, D, E }

Product generateFakeProduct() => Product(
      barcode: '3017620422003',
      name: 'Nutella',
      altName: 'Pâte à tartiner aux noisettes et au cacao',
      picture: 'https://example.com/nutella.jpg',
      quantity: '750g',
      brands: ['Ferrero'],
      manufacturingCountries: ['France'],
      nutriScore: ProductNutriscore.D,
      novaScore: ProductNovaScore.Group4,
      ecoScore: ProductEcoScore.D,
      ingredients: [
        'Sucre',
        'Huile de palme',
        'Noisettes',
        'Cacao maigre',
        'Lait écrémé en poudre',
        'Lactosérum en poudre',
        'Émulsifiant: lécithines (soja)',
        'Vanilline'
      ],
      traces: ['Arachides', 'Noix'],
      allergens: ['Lait', 'Soja', 'Noisettes'],
      additives: {'E322': 'Lécithine de soja'},
      nutrientLevels: NutrientLevels(
        salt: '0.107g',
        saturatedFat: '10.6g',
        sugars: '56.3g',
        fat: '30.9g',
      ),
      nutritionFacts: NutritionFacts(
        servingSize: '15g',
        calories: Nutriment(unit: 'kcal', perServing: 80, per100g: 533),
        fat: Nutriment(unit: 'g', perServing: 4.6, per100g: 30.9),
        saturatedFat: Nutriment(unit: 'g', perServing: 1.6, per100g: 10.6),
        carbohydrate: Nutriment(unit: 'g', perServing: 8.6, per100g: 57.5),
        sugar: Nutriment(unit: 'g', perServing: 8.4, per100g: 56.3),
        fiber: Nutriment(unit: 'g', perServing: 0.7, per100g: 6.7),
        proteins: Nutriment(unit: 'g', perServing: 0.9, per100g: 6.3),
        sodium: Nutriment(unit: 'mg', perServing: 4, per100g: 27),
        salt: Nutriment(unit: 'g', perServing: 0.01, per100g: 0.107),
        energy: Nutriment(unit: 'kJ', perServing: 335, per100g: 2252),
      ),
      ingredientsFromPalmOil: true,
    );
