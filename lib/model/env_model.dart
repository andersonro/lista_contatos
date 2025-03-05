class EnvModel {
  static const Map<String, String> _keys = {
    'API_KEY': String.fromEnvironment('API_KEY'),
  };

  static String? get(String key) {
    final value = _keys[key] ?? '';
    if (value.isEmpty) {
      throw Exception('Chave $key não encontrada');
    }
    return value;
  }

  static String get apiKey => get('API_KEY')!;
}
