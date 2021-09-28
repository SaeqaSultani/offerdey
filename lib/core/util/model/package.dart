enum Package {
  budget,
  premium,
  elite,
}

final Map<Package, Map<String, String>> packages = {
  Package.budget: {
    'packageName': 'Dawa Hazir Budget 3000PKR',
    'value': '3000',
  },
  Package.premium: {
    'packageName': 'Dawa Hazir Premium 5000PKR',
    'value': '5000',
  },
  Package.elite: {
    'packageName': 'Dawa Hazir Elite 10000PKR',
    'value': '10000',
  }
};
