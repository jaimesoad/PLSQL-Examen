import random
import json

def randAdmin():
    return random.random() > 0.8

def getRandDate():
    day = random.randint(1, 30)
    month = random.randint(1, 12)
    year = random.randint(1970, 2008)

    return f"{day}-{month}-{year}"

of = open("inserciones.sql", 'w')
data = json.load(open("data.json", 'r'))

of.write("BEGIN\n")

oper = ''
admins = []
normales = []
animes = []
listas = ["Mis Favoritas", "Viendo", "Por ver", "Vistas"]

for user in data['users']:
    if randAdmin():
        oper = "Admin"
        admins.append(user['name'].lower()+user['lastname'].lower())
    else:
        oper = "Normal"
        normales.append(user['name'].lower()+user['lastname'].lower())

    of.write(f"\tNuevo{oper}('{user['name']}', '{user['lastname']}', to_date('{getRandDate()}', 'dd-MM-yyyy'), '{user['name'].lower()+user['lastname'].lower()}', '{user['name']}.{user['lastname']}@gmail.com', '{random.randint(12345678, 99999999)}');\n")

of.write("\n")
for anime in data['animes']:
    of.write(f"\tNuevoAnime('{anime['name']}', '{anime['creator']}', '{anime['sinopsis']}', {anime['episodes']}, {anime['emission']}, '{anime['type']}', '{anime['genre']}', '{admins[random.randint(0, len(admins)-1)]}');\n")
    animes.append(anime['name'])
    pass

of.write("\n")
for i in range(5):
    of.write(f"\tUnirseAComunidad('{normales[random.randint(0, len(normales)-1)]}', '{animes[random.randint(0, len(animes)-1)]}');\n")

of.write("\n")
for i in listas:
    of.write(f"\tCrearLista('{i}', '{normales[random.randint(0, len(normales)-1)]}');\n")

of.write("END;\n")