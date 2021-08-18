import random
import numpy as np

def env(state, action):
    if state == 0:
        if action == 0:
            return -1, 2, False
        if action == 1:
            if random.random() < 0.9:
                return -1, 1, False
            else:
                return -1, 2, False
    if state == 1:
        if action == 2:
            if random.random() < 0.5:
                return -5, 2, False
            else:
                return -5, 3, False
    if state == 2:
        if action == 3:
            return -1, 3, False
        if action == 4:
            return -1, 4, True
    if state == 3:
        if action == 4:
            return -1, 4, True
    
    # invalid action
    return -10, state, False

def qlearn():
    gamma = 0.99
    alpha = 0.1
    q = np.ones((5, 6))
    q[4,:] = 0 # terminal state
    for k in range(1, 1000):
        s = 0
        epsilon = 1/k
        while True:
            if random.random() < epsilon:
                a = random.randint(0, 5)
            else:
                a = np.argmax(q[s,:])
            reward, next_state, done = env(s, a)
            q[s, a] = q[s, a] + alpha*(reward+gamma*np.max(q[next_state, :])-q[s, a])
            s = next_state
            if done:
                break
    return q


if __name__ == "__main__":
    q = qlearn()
    print(q)
    breakpoint()