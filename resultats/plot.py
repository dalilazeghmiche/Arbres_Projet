import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df = pd.read_csv("results.csv")
ALGOS = ["Remy", "ABR"]

def agg_stats(sub: pd.DataFrame, metric: str):
    g = sub.groupby("n")[metric]
    out = pd.DataFrame({
        "mean": g.mean(),
        "median": g.median(),
        "std": g.std(ddof=1)
    })
    return out

#Graphes métriques
metrics = {
    "hauteur": "Hauteur",
    "largeur": "Largeur (max nœuds par niveau)",
    "prof_feuilles": "Profondeur moyenne des feuilles",
    "taille_gauche": "Taille du sous-arbre gauche (nœuds internes)"
}

for metric, title in metrics.items():
    plt.figure()
    for algo in ALGOS:
        sub = df[df["algo"] == algo]
        stats = agg_stats(sub, metric)
        plt.plot(stats.index, stats["mean"].values, marker="o", label=f"{algo} (moyenne)")
        plt.plot(stats.index, stats["median"].values, marker="x", label=f"{algo} (médiane)")
    plt.xlabel("Taille n")
    plt.ylabel(title)
    plt.title(f"{title} en fonction de n")
    plt.grid(True)
    plt.legend()
    plt.tight_layout()
    plt.savefig(f"{metric}.png")
    plt.close()


#Graphes temps de génération
plt.figure()
for algo in ALGOS:
    sub = df[df["algo"] == algo]
    stats = agg_stats(sub, "time_ms")
    plt.plot(stats.index, stats["median"].values, marker="o", label=f"{algo} (médiane)")
plt.xlabel("Taille n")
plt.ylabel("Temps de génération (ms)")
plt.title("Temps de génération en fonction de n (médiane)")
plt.grid(True)
plt.legend()
plt.tight_layout()
plt.savefig("time_ms.png")
plt.close()

#Graphes temps normalisé par n
df2 = df.copy()
df2["time_per_n"] = df2["time_ms"] / df2["n"].replace(0, np.nan)

plt.figure()
for algo in ALGOS:
    sub = df2[df2["algo"] == algo].dropna(subset=["time_per_n"])
    stats = agg_stats(sub, "time_per_n")
    plt.plot(stats.index, stats["median"].values, marker="o", label=f"{algo} (médiane)")
plt.xlabel("Taille n")
plt.ylabel("Temps / n (ms par nœud interne)")
plt.title("Validation linéarité : temps normalisé (médiane)")
plt.grid(True)
plt.legend()
plt.tight_layout()
plt.savefig("time_per_n.png")
plt.close()

