#ifndef FILE_OPERATIONS_H
#define FILE_OPERATIONS_H

#include <vector>
#include <array>
#include <string>

void save_results_to_file(const std::vector<std::vector<std::array<int, 5>>>& results, const std::string& filename);
std::vector<std::vector<std::array<int, 5>>> read_results_from_file(const std::string& filename);

#endif // FILE_OPERATIONS_H