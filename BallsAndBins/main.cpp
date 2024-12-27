#include "experiment.h"
#include "experiment2.h"
#include "file_operations.h"

int main() {
    //auto results = experiment();
    //save_results_to_file(results, "results.txt");

    maximum_load_balanced_allocation(1);
    maximum_load_balanced_allocation(2);

    test_insertion_sort();

    communication_with_interference(0.5);
    communication_with_interference(0.1);


}