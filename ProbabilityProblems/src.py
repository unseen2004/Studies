import numpy as np
import matplotlib.pyplot as plt

# Parameters
n_values = np.arange(1000, 100001, 1000)  # n = 1000, 2000, ..., 100000
k_trials = 50  # Number of trials per n

# Initialize results storage
results = {metric: [] for metric in ["Bn", "Un", "Cn", "Dn", "Dn_minus_Cn"]}

# Simulation function
def simulate_balls_and_bins(n, k_trials):
    Bn_list, Un_list, Cn_list, Dn_list = [], [], [], []
    for _ in range(k_trials):
        bins = np.zeros(n, dtype=int)
        balls = 0
        first_collision = None
        empty_bins = n
        first_full_coverage = None
        first_double_coverage = None

        while first_double_coverage is None:
            ball_bin = np.random.randint(0, n)  # Randomly throw a ball
            balls += 1

            # Update bins and metrics
            bins[ball_bin] += 1
            if bins[ball_bin] == 2 and first_double_coverage is None:
                first_double_coverage = balls
            if bins[ball_bin] == 1:
                empty_bins -= 1
                if empty_bins == 0 and first_full_coverage is None:
                    first_full_coverage = balls
            if bins[ball_bin] == 2 and first_collision is None:
                first_collision = balls

        # Handle None values (fallback to total balls if necessary)
        if first_full_coverage is None:
            first_full_coverage = balls
        if first_double_coverage is None:
            first_double_coverage = balls

        # Store metrics for this trial
        Bn_list.append(first_collision)
        Un_list.append(empty_bins)
        Cn_list.append(first_full_coverage)
        Dn_list.append(first_double_coverage)

    return np.array(Bn_list), np.array(Un_list), np.array(Cn_list), np.array(Dn_list)

# Run simulations for each n
for n in n_values:
    Bn, Un, Cn, Dn = simulate_balls_and_bins(n, k_trials)
    results["Bn"].append(Bn)
    results["Un"].append(Un)
    results["Cn"].append(Cn)
    results["Dn"].append(Dn)
    # Ensure subtraction is valid
    results["Dn_minus_Cn"].append(Dn - Cn)

# Save results to file (optional)
np.savez("simulation_results.npz", **results)

# Visualization
for metric in results:
    plt.figure(figsize=(10, 6))
    mean_values = [np.mean(results[metric][i]) for i in range(len(n_values))]
    for trial in range(k_trials):
        plt.plot(n_values, [results[metric][i][trial] for i in range(len(n_values))], alpha=0.3, color='gray')
    plt.plot(n_values, mean_values, color='red', label=f"Mean {metric}")
    plt.title(f"{metric} vs n")
    plt.xlabel("n")
    plt.ylabel(metric)
    plt.legend()
    plt.grid()
    plt.show()

# Additional Ratios and Asymptotics Plots
def plot_ratios():
    mean_Bn = [np.mean(results["Bn"][i]) for i in range(len(n_values))]
    mean_Un = [np.mean(results["Un"][i]) for i in range(len(n_values))]
    mean_Cn = [np.mean(results["Cn"][i]) for i in range(len(n_values))]
    mean_Dn = [np.mean(results["Dn"][i]) for i in range(len(n_values))]
    mean_Dn_minus_Cn = [np.mean(results["Dn_minus_Cn"][i]) for i in range(len(n_values))]

    plt.figure(figsize=(10, 6))
    plt.plot(n_values, np.array(mean_Bn) / n_values, label="b(n)/n", color="blue")
    plt.plot(n_values, np.array(mean_Bn) / np.sqrt(n_values), label="b(n)/sqrt(n)", color="green")
    plt.title("Ratios for Bn")
    plt.xlabel("n")
    plt.ylabel("Ratio")
    plt.legend()
    plt.grid()
    plt.show()

    plt.figure(figsize=(10, 6))
    plt.plot(n_values, np.array(mean_Un) / n_values, label="u(n)/n", color="orange")
    plt.title("Ratios for Un")
    plt.xlabel("n")
    plt.ylabel("Ratio")
    plt.legend()
    plt.grid()
    plt.show()

    plt.figure(figsize=(10, 6))
    plt.plot(n_values, np.array(mean_Cn) / n_values, label="c(n)/n", color="purple")
    plt.plot(n_values, np.array(mean_Cn) / (n_values * np.log(n_values)), label="c(n)/(n ln n)", color="red")
    plt.plot(n_values, np.array(mean_Cn) / (n_values**2), label="c(n)/n^2", color="brown")
    plt.title("Ratios for Cn")
    plt.xlabel("n")
    plt.ylabel("Ratio")
    plt.legend()
    plt.grid()
    plt.show()

    plt.figure(figsize=(10, 6))
    plt.plot(n_values, np.array(mean_Dn) / n_values, label="d(n)/n", color="teal")
    plt.plot(n_values, np.array(mean_Dn) / (n_values * np.log(n_values)), label="d(n)/(n ln n)", color="pink")
    plt.plot(n_values, np.array(mean_Dn) / (n_values**2), label="d(n)/n^2", color="cyan")
    plt.title("Ratios for Dn")
    plt.xlabel("n")
    plt.ylabel("Ratio")
    plt.legend()
    plt.grid()
    plt.show()

    plt.figure(figsize=(10, 6))
    plt.plot(n_values, np.array(mean_Dn_minus_Cn) / n_values, label="(d(n)-c(n))/n", color="navy")
    plt.plot(n_values, np.array(mean_Dn_minus_Cn) / (n_values * np.log(n_values)), label="(d(n)-c(n))/(n ln n)", color="lime")
    plt.plot(n_values, np.array(mean_Dn_minus_Cn) / (n_values * np.log(np.log(n_values))), label="(d(n)-c(n))/(n ln ln n)", color="maroon")
    plt.title("Ratios for Dn - Cn")
    plt.xlabel("n")
    plt.ylabel("Ratio")
    plt.legend()
    plt.grid()
    plt.show()

plot_ratios()
