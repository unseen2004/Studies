#ifndef RANDOM_MT_H
#define RANDOM_MT_H

#include <chrono>
#include <random>


namespace Random
{

    inline std::mt19937 generate()
    {
        std::random_device rd{};

        std::seed_seq ss{
            static_cast<std::seed_seq::result_type>(std::chrono::steady_clock::now().time_since_epoch().count()),
            rd(), rd(), rd(), rd(), rd(), rd(), rd() };

        return std::mt19937{ ss };
    }

    inline std::mt19937 mt{ generate() };


    template <typename T>
    T get(T min, T max)
    {
        if constexpr (std::is_integral<T>::value)
        {
            return std::uniform_int_distribution<T>{min, max}(mt);
        }
        else if constexpr (std::is_floating_point<T>::value)
        {
            return std::uniform_real_distribution<T>{min, max}(mt);
        }
    }

}

#endif
