#include <iostream>
#include <vector>
#include <limits>
using namespace std;

// Precondicion: i y j son indices validos del array
void intercambiar(int* arr, int i, int j) {
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

void selectionSort(int* arr, int n) {
    int i, j, min_idx;
    for (i = 0; i < n - 1; i++) {
        min_idx = i;
        for (j = i + 1; j < n; j++) {
            if (arr[j] < arr[min_idx]) {
                min_idx = j;
            }
        }
        intercambiar(arr, min_idx, i);
    }
}
// Siendo N: cantidad de elementos del array
// N del primer for *
// N del segundo for
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
    selectionSort(nums, 10);
    showArray(nums, 10);

    showArray(nums2, 10);
    selectionSort(nums2, 10);
    showArray(nums2, 10);
    return 0;
}
