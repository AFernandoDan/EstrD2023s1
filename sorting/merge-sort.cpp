#include <iostream>
#include <vector>
#include <limits>
using namespace std;


// Merges two subarrays of arr[].
// First subarray is arr[l..m]
// Second subarray is arr[m+1..r]
void merge(int arr[], int l, int m, int r)
{
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;
 
    // Create temp arrays
    int sai[n1], sad[n2];
 
    // Copy data to temp arrays
    // L[] and R[]
    for (i = 0; i < n1; i++)
        sai[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        sad[j] = arr[m + 1 + j];
 
    // Merge the temp arrays back
    // into arr[l..r]
    // Initial index of first subarray
    i = 0;
 
    // Initial index of second subarray
    j = 0;
 
    // Initial index of merged subarray
    k = l;
    while (i < n1 && j < n2)
    {
        if (sai[i] <= sad[j])
        {
            arr[k] = sai[i];
            i++;
        }
        else
        {
            arr[k] = sad[j];
            j++;
        }
        k++;
    }
 
    // Copy the remaining elements
    // of L[], if there are any
    while (i < n1) {
        arr[k] = sai[i];
        i++;
        k++;
    }
 
    // Copy the remaining elements of
    // R[], if there are any
    while (j < n2)
    {
        arr[k] = sad[j];
        j++;
        k++;
    }
}
 
// l is for left index and r is
// right index of the sub-array
// of arr to be sorted
void mergeSort(int arr[], int l, int r)
{
    if (l < r)
    {
        // Same as (l+r)/2, but avoids
        // overflow for large l and h
        int m = l + (r - l) / 2;
 
        // Sort first and second halves
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
 
        merge(arr, l, m, r);
    }
}

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
    int size_nums = 10;
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
    int size_nums2 = 10;

    showArray(nums, 10);
    mergeSort(nums, 0, size_nums -1);
    showArray(nums, 10);

    showArray(nums2, 10);
    mergeSort(nums2, 0, size_nums2 -1);
    showArray(nums2, 10);
    return 0;
}
