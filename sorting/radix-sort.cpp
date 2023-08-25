#include <iostream>
#include <vector>
#include <limits>
using namespace std;

void countingSort(int* nums, int n, int exp) {
    const int countSize = 10;
    int* count = new int[countSize]();
    for (int i = 0; i < n; i++) {
        count[(nums[i] / exp) % 10]++;
    }

    int index = 0;
    for (int i = 0; i < countSize; i++) {
        while (count[i] > 0) {
            nums[index++] = i * exp + nums[index] % exp;
            count[i]--;
        }
    }

    delete[] count;
}

void radixSort(int* nums, int n) {
    int max = nums[0];
    for (int i = 1; i < n; i++) {
        if (nums[i] > max)
            max = nums[i];
    }

    for (int exp = 1; max / exp > 0; exp *= 10) {
        countingSort(nums, n, exp);
    }
}
/* costo: O(n + k)
  * n: cantidad de elementos del array
  * k: rango de valores
*/

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
    radixSort(nums, 10);
    showArray(nums, 10);

    showArray(nums2, 10);
    radixSort(nums2, 10);
    showArray(nums2, 10);
    return 0;
}
