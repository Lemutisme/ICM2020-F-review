import matplotlib.pyplot as plt

class SEIR:
    
    def __init__(self, T, N, E, I, R, r1, r2, b1, b2, a, g):
        
        self.N = N
        self.E = [E]
        self.I = [I]
        self.R = [R]
        self.S = [N - I]
        self.r1 = r1
        self.r2 = r2
        self.b1 = b1
        self.b2 = b2
        self.a = a
        self.g = g
        self.T = T
    
    def calculate(self):
        
        if len(self.T) == len(self.S):
            return
        for i in range(0, len(self.T) - 1):
            self.S.append(self.S[i] - self.r1 * self.b1 * self.S[i] * self.I[i] / self.N - self.r2 * self.b2 * self.S[i] * self.E[i] / self.N)
            self.E.append(self.E[i] + self.r1 * self.b1 * self.S[i] * self.I[i] / self.N - self.a * self.E[i] + self.r2 * self.b2 * self.S[i] * self.E[i] / self.N)
            self.I.append(self.I[i] + self.a * self.E[i] - self.g * self.I[i])
            self.R.append(self.R[i] + self.g * self.I[i])
    
    def plot(self):
        
        if len(self.S) == 1:
            self.calculate()
        plt.figure()
        plt.title("SEIR Spread Plot")
        plt.plot(self.T, self.S, color = 'b', label = 'Susceptible')
        plt.plot(self.T, self.E, color = 'y', label = 'Exposed')
        plt.plot(self.T, self.I, color = 'r', label = 'Infectious')
        plt.plot(self.T, self.R, color = 'g', label = 'Recovered')
        plt.grid(False)
        plt.legend()
        plt.xlabel("Time")
        plt.ylabel("Population")
        plt.show()

if __name__ == "__main__":
    
    T = [i for i in range(160)]
    s = SEIR(T, 1e5, 0, 17, 0, 21, 21, 0.048, 0.048, 0.13, 0.066)
    s.plot()
