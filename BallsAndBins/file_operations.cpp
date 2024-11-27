#include "file_operations.h"
#include <fstream>
#include <iostream>
#include <filesystem>

void save_results_to_file(const std::vector<std::vector<std::array<int, 5>>>& results, const std::string& filename) {
    std::filesystem::path filepath = std::filesystem::current_path().parent_path() / filename;
    std::ofstream outfile(filepath);
    if (!outfile.is_open()) {
        std::cerr << "Failed to open file for writing: " << filepath << std::endl;
        return;
    }
    for (const auto& r_exp : results) {
        for (const auto& r : r_exp) {
            outfile << r[0] << " " << r[1] << " " << r[2] << " " << r[3] << " " << r[4] << "\n";
        }
    }
    outfile.close();
    if (outfile.fail()) {
        std::cerr << "Failed to write to file: " << filepath << std::endl;
    } else {
        std::cout << "Results successfully written to " << std::filesystem::absolute(filepath) << std::endl;
    }
}

std::vector<std::vector<std::array<int, 5>>> read_results_from_file(const std::string& filename) {
    std::filesystem::path filepath = std::filesystem::current_path().parent_path() / filename;
    std::vector<std::vector<std::array<int, 5>>> results;
    std::ifstream infile(filepath);
    if (!infile.is_open()) {
        std::cerr << "Failed to open file for reading: " << filepath << std::endl;
        return results;
    }
    int birthday_paradox, n_empty_bins, coupon_collector_problem, m_two_balls, mtb_ccp;

    for (int n = 1000; n <= 100000; n += 1000) {
        std::vector<std::array<int, 5>> r_exp;
        for (int k = 0; k < 50; ++k) {
            infile >> birthday_paradox >> n_empty_bins >> coupon_collector_problem >> m_two_balls >> mtb_ccp;
            r_exp.push_back({birthday_paradox, n_empty_bins, coupon_collector_problem, m_two_balls, mtb_ccp});
        }
        results.push_back(r_exp);
    }
    infile.close();
    if (infile.fail()) {
        std::cerr << "Failed to read from file: " << filepath << std::endl;
    } else {
        std::cout << "Results successfully read from " << filepath << std::endl;
    }
    return results;
}