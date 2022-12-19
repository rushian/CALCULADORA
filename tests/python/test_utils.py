import os
from pathlib import Path
from resources.utils.file_manager import ler_dado_celula
from resources.utils.file_manager import ler_dado_celula_ao_lado
from resources.utils.general import randomize_value
from resources.utils.general import baixar_arquivo
from resources.utils.general import limpar_cache


def test_ler_dado_celula():
    aba = 'contratos'
    celula = 'C2'
    arquivo = 'vendors/xlsx/massa.xlsx'
    resultado_esperado = '02115109120'
    resultado_obtido =    ler_dado_celula(arquivo, aba, celula)
    print(resultado_obtido)
    
    assert resultado_esperado == resultado_obtido


def test_ler_dado_celula_ao_lado():
    aba = 'contratos'
    celula = 'c2'
    arquivo = 'vendors/xlsx/massa.xlsx'
    resultado_esperado = 102030
    resultado_obtido =    ler_dado_celula_ao_lado(arquivo, aba, celula)
    print(resultado_obtido)
    
    assert resultado_esperado == resultado_obtido


def test_baixa_arquivo():
    resultado_obtido = baixar_arquivo('https://bcr.bstqb.org.br/docs/syllabus_ctfl_3.1br.pdf', 'c:\\qa')
    print(resultado_obtido)
    



def test_randomize_value():
    valor_obtido = randomize_value(1, 3)
    print(valor_obtido)
    assert int


def test_limpar_cache():
    # configura
    pasta_projeto = str(Path.cwd().parents[1])
    pastas_cache = 0
    for diretorio, subpastas, arquivos in os.walk(pasta_projeto):
        for subpasta in subpastas:
            if 'pytest_cache' in subpasta:
                pastas_cache += 1
    resultado_esperado = pastas_cache
    # executa
    resultado_obtido = limpar_cache(pasta_projeto)
    # verifica
    assert resultado_obtido == resultado_esperado

