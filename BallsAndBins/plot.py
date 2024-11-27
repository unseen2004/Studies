import numpy as np
import matplotlib.pyplot as plt


# Function to read the results from the file
def read_results(filename):
    data = np.loadtxt(filename)
    return data.reshape((-1, 50, 5))


# Function to plot the results
def plot_results(results):
    n_values = np.arange(1000, 100001, 1000)
    avg_birthday_paradox = np.mean(results[:, :, 0], axis=1)
    avg_n_empty_bins = np.mean(results[:, :, 1], axis=1)
    avg_coupon_collector_problem = np.mean(results[:, :, 2], axis=1)
    avg_m_two_balls = np.mean(results[:, :, 3], axis=1)
    avg_mtb_ccp = np.mean(results[:, :, 4], axis=1)

    fig, axs = plt.subplots(2, 3, figsize=(15, 10))

    # Plot Birthday Paradox (Bn)
    axs[0, 0].scatter(n_values.repeat(50), results[:, :, 0].flatten(), s=2)
    axs[0, 0].plot(n_values, avg_birthday_paradox, 'r-')
    axs[0, 0].set_title("Birthday Paradox (Bn)")
    axs[0, 0].set_xlabel("n")
    axs[0, 0].set_ylabel("Bn")

    # Plot Number of Empty Bins after n balls (Un)
    axs[0, 1].scatter(n_values.repeat(50), results[:, :, 1].flatten(), s=2)
    axs[0, 1].plot(n_values, avg_n_empty_bins, 'r-')
    axs[0, 1].set_title("Number of Empty Bins (Un)")
    axs[0, 1].set_xlabel("n")
    axs[0, 1].set_ylabel("Un")

    # Plot Coupon Collector's Problem (Cn)
    axs[0, 2].scatter(n_values.repeat(50), results[:, :, 2].flatten(), s=2)
    axs[0, 2].plot(n_values, avg_coupon_collector_problem, 'r-')
    axs[0, 2].set_title("Coupon Collector's Problem (Cn)")
    axs[0, 2].set_xlabel("n")
    axs[0, 2].set_ylabel("Cn")

    # Plot First Moment All Bins Have at Least 2 Balls (Dn)
    axs[1, 0].scatter(n_values.repeat(50), results[:, :, 3].flatten(), s=2)
    axs[1, 0].plot(n_values, avg_m_two_balls, 'r-')
    axs[1, 0].set_title("All Bins Have at Least 2 Balls (Dn)")
    axs[1, 0].set_xlabel("n")
    axs[1, 0].set_ylabel("Dn")

    # Plot Dn - Cn
    axs[1, 1].scatter(n_values.repeat(50), results[:, :, 4].flatten(), s=2)
    axs[1, 1].plot(n_values, avg_mtb_ccp, 'r-')
    axs[1, 1].set_title("Difference Dn - Cn")
    axs[1, 1].set_xlabel("n")
    axs[1, 1].set_ylabel("Dn - Cn")

    # Combined plot for comparing all averages
    axs[1, 2].plot(n_values, avg_birthday_paradox, label="Bn")
    axs[1, 2].plot(n_values, avg_n_empty_bins, label="Un")
    axs[1, 2].plot(n_values, avg_coupon_collector_problem, label="Cn")
    axs[1, 2].plot(n_values, avg_m_two_balls, label="Dn")
    axs[1, 2].plot(n_values, avg_mtb_ccp, label="Dn - Cn")
    axs[1, 2].set_title("Averages Comparison")
    axs[1, 2].set_xlabel("n")
    axs[1, 2].set_ylabel("Average Values")
    axs[1, 2].legend()

    plt.tight_layout()
    plt.savefig("results_plots.pdf")
    plt.show()

    # Additional plots
    fig, axs = plt.subplots(2, 3, figsize=(15, 10))

    # Plot b(n)/n and b(n)/sqrt(n) as functions of n
    axs[0, 0].plot(n_values, avg_birthday_paradox / n_values, label="b(n)/n")
    axs[0, 0].plot(n_values, avg_birthday_paradox / np.sqrt(n_values), label="b(n)/sqrt(n)")
    axs[0, 0].set_title("Ratios of Bn")
    axs[0, 0].set_xlabel("n")
    axs[0, 0].set_ylabel("Ratio")
    axs[0, 0].legend()

    # Plot u(n)/n as a function of n
    axs[0, 1].plot(n_values, avg_n_empty_bins / n_values, label="u(n)/n")
    axs[0, 1].set_title("Ratio of Un")
    axs[0, 1].set_xlabel("n")
    axs[0, 1].set_ylabel("Ratio")
    axs[0, 1].legend()

    # Plot c(n)/n, c(n)/(n ln n), and c(n)/n^2 as functions of n
    axs[0, 2].plot(n_values, avg_coupon_collector_problem / n_values, label="c(n)/n")
    axs[0, 2].plot(n_values, avg_coupon_collector_problem / (n_values * np.log(n_values)), label="c(n)/(n ln n)")
    axs[0, 2].plot(n_values, avg_coupon_collector_problem / (n_values**2), label="c(n)/n^2")
    axs[0, 2].set_title("Ratios of Cn")
    axs[0, 2].set_xlabel("n")
    axs[0, 2].set_ylabel("Ratio")
    axs[0, 2].legend()

    # Plot d(n)/n, d(n)/(n ln n), and d(n)/n^2 as functions of n
    axs[1, 0].plot(n_values, avg_m_two_balls / n_values, label="d(n)/n")
    axs[1, 0].plot(n_values, avg_m_two_balls / (n_values * np.log(n_values)), label="d(n)/(n ln n)")
    axs[1, 0].plot(n_values, avg_m_two_balls / (n_values**2), label="d(n)/n^2")
    axs[1, 0].set_title("Ratios of Dn")
    axs[1, 0].set_xlabel("n")
    axs[1, 0].set_ylabel("Ratio")
    axs[1, 0].legend()

    # Plot (d(n) - c(n))/n, (d(n) - c(n))/(n ln n), and (d(n) - c(n))/(n ln ln n) as functions of n
    axs[1, 1].plot(n_values, (avg_m_two_balls - avg_coupon_collector_problem) / n_values, label="(d(n) - c(n))/n")
    axs[1, 1].plot(n_values, (avg_m_two_balls - avg_coupon_collector_problem) / (n_values * np.log(n_values)), label="(d(n) - c(n))/(n ln n)")
    axs[1, 1].plot(n_values, (avg_m_two_balls - avg_coupon_collector_problem) / (n_values * np.log(np.log(n_values))), label="(d(n) - c(n))/(n ln ln n)")
    axs[1, 1].set_title("Ratios of Dn - Cn")
    axs[1, 1].set_xlabel("n")
    axs[1, 1].set_ylabel("Ratio")
    axs[1, 1].legend()

    plt.tight_layout()
    plt.savefig("additional_results_plots.pdf")
    plt.show()


# Main execution
results = read_results("results.txt")
plot_results(results)