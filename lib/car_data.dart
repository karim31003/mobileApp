// lib/car_data.dart

final Map<String,  List<String>> brandModels = {
  'Alfa Romeo': ['Giulia', 'Stelvio', '4C Coupe'],
  'Audi':        ['A3', 'A4', 'Q5'],
  'Ford':        ['Mustang'],
  'Toyota':      ['Corolla'],
};

final Map<String, Map<String, String>> modelDetails = {
  // 'Giulia': {
  //   'price':       '45.480 €',
  //   'description': 'Giulia Veloce 2.0L AT8 280PS "Leder" LED Navi',
  //   'specs':       '8.0L/100km • 182g/km CO₂',
  //   'image':       'assets/giulia.jpg', // ← NEED THIS FILE
  // },
  'Stelvio': {
    'price':       '52.300 €',
    'description': 'Stelvio 2.0L 280PS Q4 Veloce',
    'specs':       '8.2L/100km • 187g/km CO₂',
    'image':       'assets/stelvio.jpg',
  },
  // '4C Coupe': {
  //   'price':       '60.000 €',
  //   'description': '4C Coupe 1.75 Turbo',
  //   'specs':       '6.8L/100km • 157g/km CO₂',
  //   'image':       'assets/giulia.jpg', 
  // },
  'A3': {
    'price':       '30.000 €',
    'description': 'Audi A3 Sportback',
    'specs':       '5.5L/100km • 127g/km CO₂',
    'image':       'assets/a4.jpg',
  },
  'A4': {
    'price':       '43.000 €',
    'description': 'Audi A4 40 TFSI S tronic advanced',
    'specs':       '6.5L/100km • 148g/km CO₂',
    'image':       'assets/a4.jpg',
  },
  'Q5': {
    'price':       '50.000 €',
    'description': 'Audi Q5 45 TFSI quattro',
    'specs':       '7.1L/100km • 162g/km CO₂',
    'image':       'assets/a4.jpg',
  },
  'Mustang': {
    'price':       '60.000 €',
    'description': 'Ford Mustang GT 5.0 V8 450PS',
    'specs':       '12.0L/100km • 275g/km CO₂',
    'image':       'assets/mustang.jpg',
  },
  'Corolla': {
    'price':       '27.000 €',
    'description': 'Toyota Corolla 1.8 Hybrid Comfort',
    'specs':       '4.5L/100km • 102g/km CO₂',
    'image':       'assets/corolla.jpg',
  },
};
