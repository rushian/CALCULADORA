import random
import requests 
import urllib.request
import os
import shutil
from pathlib import Path


def randomize_value(start: int, end: int):
    return random.randrange(start,end)



def limpar_cache(pasta_projeto):
    pastas_deletadas = 0
    for diretorio, subpastas, arquivos in os.walk(pasta_projeto):
        for subpasta in subpastas:
            if 'pytest_cache' in subpasta:
                pastas_deletadas += 1
                shutil.rmtree(os.path.join(diretorio, subpasta), ignore_errors=True)

    return pastas_deletadas


def baixar_arquivo(url, endereco):
    try:
        resposta = requests.get(
                url=url,
                headers={'Content-Type':'application/pdf'}
            )
        if resposta.status_code == requests.codes.OK:
            with open(endereco, 'wb') as novo_arquivo:
                    novo_arquivo.write(resposta.content)
            print("Download finalizado. Arquivo salvo em: {}".format(endereco))
        else:
            resposta.raise_for_status()
    except:
        resposta = requests.get(url)

        print('nao foi possivel fazer o download - ', resposta.status_code)

def listar_digitos(valor):
    lista = []
    valor_digitado = str(valor)
    for caracter in valor_digitado:
        lista.append(caracter)
    return lista

