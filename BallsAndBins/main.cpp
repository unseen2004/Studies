#include "experiment.h"
#include "file_operations.h"
#include <iostream>

int main() {
    auto results = experiment();
    save_results_to_file(results, "results.txt");
}