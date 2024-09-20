class Paginated<T> {
  final List<T> items;
  final Future<Paginated<T>> Function()? next;

  Paginated(
    this.items,
    this.next,
  );
}
