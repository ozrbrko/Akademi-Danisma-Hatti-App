extension StringExtensionText on String {
  String ilkHarfBuyut() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
  String toLower() => length > 0 ?'${this[0].toLowerCase()}${substring(1).toLowerCase()}':'';

  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String basHarfleriBuyut() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}