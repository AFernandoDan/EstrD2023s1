#include <iostream>
#include <vector>
#include <limits>
using namespace std;

void insertionSort(int* arr, int n) {
    int i, key, j;
    for (i = 1; i < n; i++) {
        key = arr[i];
        j = i - 1;

        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j + 1] = key;
    }
}

// Siendo N: cantidad de elementos del array
// N (del for) *
// N (del while, en peor caso al undir el elemento).
// Costo O(N^2)

void showArray(int* nums, int n) {
  cout << "[";
  for (int i = 0; i < n; i++) {
    cout << nums[i];
    if (i < n - 1) {
      cout << ", ";
    }
  }
  cout << "]" << endl;
}

int main() {
    int* nums = new int[10];
    nums[0] = 5;
    nums[1] = 2;
    nums[2] = 4;
    nums[3] = 6;
    nums[4] = 1;
    nums[5] = 3;
    nums[6] = 7;
    nums[7] = 9;
    nums[8] = 0;
    nums[9] = 8;

    int nums2[] = {5, 2, 4, 6, 1, 3, 7, 9, 0, 8};

    showArray(nums, 10);
    insertionSort(nums, 10);
    showArray(nums, 10);

    showArray(nums2, 10);
    insertionSort(nums2, 10);
    showArray(nums2, 10);
    return 0;
}
