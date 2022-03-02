# 5 conceitos fundamentais para começar a programar em R

#### Variáveis e seus tipos

nome = "Paula Macaira"
typeof(nome)

idade = 32
typeof(idade)

#### Estruturas lógicas e condicionais

if(idade < 25){"Geração Z"}else{"Cringe"}

#### Estruturas de repetição

lista = list(nome, idade, "18/01/1990")
for(i in seq_along(lista)){print(lista[i])}

#### Funções

somar_produto = function(vetor1, vetor2){sum(vetor1*vetor2)}
somar_produto(1:10,100:1)

#### Exportar e importar arquivos

write.csv2(iris,"base_iris.csv")
novo = read.csv2("base_iris.csv")
novo
