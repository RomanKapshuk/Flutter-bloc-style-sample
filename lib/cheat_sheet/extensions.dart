extension ListExtension<E> on List<E> {
  addIfNotNull(E? value) {
    if (value != null) {
      add(value);
    }
  }
}