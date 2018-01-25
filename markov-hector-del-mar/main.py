import requests
import random
from bs4 import BeautifulSoup
from collections import defaultdict

r = requests.get("https://es.wikiquote.org/wiki/H%C3%A9ctor_del_Mar")

soup = BeautifulSoup(r.text,"lxml")

frases = map(lambda x: x.text.replace("\"",""),soup.select(".mw-parser-output li"))

palabras = map(lambda x: str(x).split(" "),frases)

almacen = defaultdict(lambda: list())

def add_word(prev,next):
    global almacen
    almacen[prev].append(next)

def gen_word():
    word = list()
    state = "START","START"
    while True:
        w = random.choice(almacen[state]) # can fail
        word.append(w)
        state = state[1],w
        if w.endswith(".") or w.endswith("!"):
            return " ".join(word)

for frase in palabras:
    frase = list(frase)
    for i,palabra in enumerate(frase):
        if i == 0:
            add_word(("START","START"),palabra)
            continue
        if i == 1:
            add_word(("START",frase[0]),palabra)
            continue
        add_word((frase[i-2],frase[i-1]),palabra)

print(gen_word())


