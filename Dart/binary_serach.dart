import 'dart:math';

int randomLimit = 5000000;

int randomNumber(n) => Random().nextInt(n);

List<int> randomList(int n) =>
    List.generate(n, (_) => _ + randomNumber(randomLimit));
void main() {
  int n = 10000000;
  List<int> array = randomList(n)..sort();

  int item = randomNumber(randomLimit) * randomNumber(n);

  Stopwatch stopwatch = Stopwatch()..start();
  print('linerSearch($item) : ${linerSearch(array, item)}');
  stopwatch.stop();
  print('Time(${stopwatch.elapsedMicroseconds}ms)');
  stopwatch.reset();
  stopwatch.start();
  print('\n---------\n');
  print('binarySearch($item) : ${binarySearch(array, item)}');
  stopwatch.stop();
  print('Time(${stopwatch.elapsedMicroseconds})');
}

int binarySearch(List<int> array, int item) {
  int mid = 0;
  int low = 0;
  int high = array.length - 1;
  int count = 0;

  while (low != high) {
    mid = (low + high) ~/ 2;
    count++;
    if (item == array[mid]) {
      print('Number of itrations : ${count + 1}');
      return mid;
    } else if (item > array[mid]) {
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  }
  print('Number of itrations : ${count + 1}');
  return -1;
}

int linerSearch(List<int> array, int item) {
  for (int i = 0; i < array.length; i++) {
    if (array[i] == item) {
      print('Number of itrations : ${i + 1}');
      return i;
    }
  }
  print('Number of itrations : ${array.length}');
  return -1;
}
