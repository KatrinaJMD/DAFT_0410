# -*- coding: utf-8 -*-
"""main.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/17szON7tJkJa1X_gbskLzo7wjTiswXx1D

## Original code
"""

def risk():
    
    import random

    while True:
        try:

            a = int(input("No. of armies to deploy: "))

            a = a
            d = a
            x = a
            rounds = 0

            while (a != 0) or (d != 0):
            
                lst_a = []
                lst_d = []

                rounds += 1      

                for i in range(a):
                    lst_a.append(random.randrange(1, 11))
                for i in range(d):
                    lst_d.append(random.randrange(1, 11))     

                lst_a.sort(reverse=True)
                lst_d.sort(reverse=True)        

                print("\n")
                print(f"ROUND {rounds}")
                print("-" * 38)
                print(f"Attacker = {lst_a}")
                print(f"Defender = {lst_d}")     

                loss_a = 0
                loss_d = 0      


                for i in range(x):
                    if lst_a[i] > lst_d[i]:
                        loss_d += 1
                    elif lst_a[i] < lst_d[i]:
                        loss_a += 1
                    elif lst_a[i] == lst_d[i]:
                        loss_a += 1  


                a_remain = len(lst_a) - loss_a
                d_remain = len(lst_d) - loss_d  

                if a_remain >= d_remain:
                    x = d_remain
                elif a_remain < d_remain:
                    x = a_remain

                print("\n")
                print(f"Attacker lost {loss_a} armies, {a_remain} armies left.")
                print(f"Defender lost {loss_d} armies, {d_remain} armies left.")  

                # print("\n")
                # if a_remain < d_remain:
                #      print("DEFENDER WINS!!!")
                # elif a_remain == d_remain:
                #      print("DEFENDER WINS!!!")
                # elif a_remain > d_remain:
                #      print("ATTACKER WINS!!!")

                print("\n")
                if a_remain == 0:
                    print("DEFENDER WINS!!!")
                    break
                elif d_remain == 0:
                    print("ATTACKER WINS!!!")
                    break   

                a = a_remain
                d = d_remain

        except ValueError:
            print("Invalid input. Please enter a number.")
            continue

        print("\n")
        choice = input("Do you want to play again (y/n): ")
        while choice.lower() not in ["y","n"]:
            choice = input("Please choose yes (y) or no (n): ")
        if choice.lower() == "n":
            print("Okay. Have a great day!")
            break
        print("\n")

"""## Refactored
I refactored my code with improved variable names, function extraction, and better readability. Here's the refactored version:
"""

import random

def risk():
    while True:
        try:
            num_armies = int(input("No. of armies to deploy: "))
            play_game(num_armies)

        except ValueError:
            print("Invalid input. Please enter a number.")
            continue

        if not prompt_play_again():
            print("Okay. Have a great day!")
            break
        print("\n")


def play_game(num_armies):
    attacker = num_armies
    defender = num_armies
    battle_size = num_armies
    rounds = 0

    while attacker != 0 and defender != 0:
        rounds += 1
        attacker_armies, defender_armies = generate_armies(attacker, defender)

        print_round_info(rounds, attacker_armies, defender_armies)

        attacker_loss, defender_loss = compare_armies(attacker_armies, defender_armies, battle_size)

        attacker_remaining = len(attacker_armies) - attacker_loss
        defender_remaining = len(defender_armies) - defender_loss

        battle_size = min(attacker_remaining, defender_remaining)

        print(f"\nAttacker lost {attacker_loss} armies, {attacker_remaining} armies left.")
        print(f"Defender lost {defender_loss} armies, {defender_remaining} armies left.\n")

        if attacker_remaining == 0:
            print("DEFENDER WINS!!!")
            break
        elif defender_remaining == 0:
            print("ATTACKER WINS!!!")
            break

        attacker = attacker_remaining
        defender = defender_remaining


def generate_armies(attacker, defender):
    attacker_armies = sorted([random.randrange(1, 11) for _ in range(attacker)], reverse=True)
    defender_armies = sorted([random.randrange(1, 11) for _ in range(defender)], reverse=True)
    return attacker_armies, defender_armies


def print_round_info(rounds, attacker_armies, defender_armies):
    print(f"\nROUND {rounds}")
    print("-" * 38)
    print(f"Attacker = {attacker_armies}")
    print(f"Defender = {defender_armies}")


def compare_armies(attacker_armies, defender_armies, battle_size):
    attacker_loss = 0
    defender_loss = 0

    for i in range(battle_size):
        if attacker_armies[i] > defender_armies[i]:
            defender_loss += 1
        elif attacker_armies[i] <= defender_armies[i]:
            attacker_loss += 1

    return attacker_loss, defender_loss


def prompt_play_again():
    choice = input("Do you want to play again (y/n): ").lower()
    while choice not in ["y", "n"]:
        choice = input("Please choose yes (y) or no (n): ").lower()
    return choice == "y"


if __name__ == "__main__":
    risk()