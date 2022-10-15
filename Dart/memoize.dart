import 'dart:math';

int randomLimit = 50;

int randomNumber(n) => Random().nextInt(n);

List<int> randomList(int n) =>
    List.generate(n, (_) => _ + randomNumber(randomLimit));

void main() {
  print(multipleWithRandom(5));
  print(memoize(multipleWithRandom)(5));
  print(memoize(multipleWithRandom)(5));

  int n = 100;
  List<int> array = randomList(n)..sort();

  int item = randomNumber(randomLimit) * randomNumber(n);

  Stopwatch stopwatch = Stopwatch()..start();
  print('1.linerSearch($item) : ${memoizeLiner(linerSearch)(array, item, 0)}');
  stopwatch.stop();
  print('Time(${stopwatch.elapsedMicroseconds}ms)');
  stopwatch.reset();
  stopwatch.start();
  print('\n---------\n');
  print('2.linerSearch($item) : ${memoizeLiner(linerSearch)(array, item, 0)}');
  stopwatch.stop();
  print('Time(${stopwatch.elapsedMicroseconds})');
  stopwatch.reset();
  stopwatch.start();
  print('\n---------\n');
  print(
      '1.binarySearch($item) : ${memoizeBinary(binarySearch)(array, item, 0, array.length - 1)}');
  stopwatch.stop();
  print('Time(${stopwatch.elapsedMicroseconds})');
  stopwatch.reset();
  stopwatch.start();
  print('\n---------\n');
  print(
      '2.binarySearch($item) : ${memoizeBinary(binarySearch)(array, item, 0, array.length - 1)}');
  stopwatch.stop();
  print('Time(${stopwatch.elapsedMicroseconds})');
}

Map cache = {};
// A method to memoize a function
Function memoize(Function f) {
  return ([arg]) => cache.containsKey(arg) ? cache[arg] : cache[arg] = f(arg);
}

Function memoizeLiner(f(List<int> array, int item, int index)) {
  // Create a key from the arguments
  return (array, item, index) {
    String key = '${array.length}-${item}-${index}';
    return cache.containsKey(key)
        ? cache[key]
        : cache[key] = f(array, item, index);
  };
}

Function memoizeBinary(f(List<int> array, int item, int low, int high)) {
  // Create a key from the arguments
  return (array, item, low, high) {
    String key = '${array.length}-${item}-${low}-${high}';
    return cache.containsKey(key)
        ? cache[key]
        : cache[key] = f(array, item, low, high);
  };
}

int multipleWithRandom(int n) => n * Random().nextInt(9999999);

// Binary Search with recursion
int binarySearch(List<int> array, int item, int low, int high) {
  if (low > high) return -1;
  int mid = (low + high) ~/ 2;
  if (item == array[mid]) {
    return mid;
  } else if (item > array[mid]) {
    return binarySearch(array, item, mid + 1, high);
  } else {
    return binarySearch(array, item, low, mid - 1);
  }
}

// Liner Search with recursion
int linerSearch(List<int> array, int item, int index) {
  if (index == array.length) return -1;
  if (array[index] == item) {
    return index;
  } else {
    return linerSearch(array, item, index + 1);
  }
}
