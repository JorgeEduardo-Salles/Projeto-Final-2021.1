# Relatório de Produtividade de Processos

#### Aluno: [Jorge eduardo Salgado Salles](https://github.com/JorgeEduardo-Salles).
#### Orientador: [Anderson Nascimento](https://github.com/insightds).

---

Trabalho apresentado ao curso [BI MASTER](https://ica.puc-rio.ai/bi-master) como pré-requisito para conclusão de curso e obtenção de crédito na disciplina "Projetos de Sistemas Inteligentes de Apoio à Decisão".

---

### Resumo

Este artigo demonstra a execução de visualização de dados para suporte de decisões no âmbito de um órgão público do Estado do Rio de Janeiro. A partir da ferramenta Pentaho, procedeu-se a extração, transformação e carregamento dos dados no Postgres, com base em um Datawarehouse estruturado com a ferramenta Powerartchitect. Posteriormente criou-se visualizações de relatórios de interesse no Power-BI. O processo mostrou-se adequado para os fins a que se propôs, que era permitir uma interação rápida e customizável dos auditories com os dados internos da instituição, com vistas a tomada de decisão.

### Abstract 

This article demonstrates the implementation of data visualization to support decisions within a public agency in the State of Rio de Janeiro. Using the Pentaho tool, data was extracted, transformed and loaded into Postgres, based on a Datawarehouse structured with the Powerartchitect tool. Subsequently, views of reports of interest were created in Power-BI. The process proved to be suitable for the purposes it was proposed, which was to allow a quick and customizable interaction of the auditors with the institution's internal data, focusing on making decisions.

### 1. Introdução

Uma das formas de medição da produtividade das subsecretarias vinculadas à Secretaria Geral de Controle Externo é a partir dos processos que são tramitados. 
O sistema que controla os processos – SCAP – possui muitas informações relevantes para o gerenciamento da produtividade dos setores, porém não possui relatórios suficientemente detalhados que permitam que os gestores, de forma rápida e eficiente, obtenham as informações necessárias para informar os relatórios que lhes são demandados e muito menos para que possam ter permanente controle das atividades que estão sendo desempenhadas sem esforço considerável de mão de obra para produzir as informações.

Atualmente, para que seja possível obter uma base única com as informações, de modo que se possa utilizar qualquer ferramenta de análise, como o PowerBI ou o próprio Excel, a subsecretaria precisa gerar 2 (dois) relatórios diferentes existentes no sistema SCAP, sendo que um deles precisa ser gerado por cada setor. Ou seja, como a subsecretaria possui 4 (quatro) coordenadorias de auditoria, é preciso gerar um total de 4 (quatro) relatórios para que depois sejam compilados manualmente e, aí sim, seja possível a utilização das ferramentas de análise.

Não bastasse o trabalho de compilação, os dados dos relatórios são gerados em formatos diferentes, havendo a necessidade de transformações diferentes em cada um deles para que fiquem no mesmo formato para que possam ser compilados.

Espera-se que este projeto permita a automatização dessa tarefa a partir dos relatórios gerados, com a definição de um DW compilado e formatado, que possibilite a criação de diferentes visualizações que facilitem a tomada de decisão e a geração de relatórios gerenciais.

Faz parte desse trabalho o desenvolvimento de 03 (três) painéis BI para visualização de resumos gerais cuja demanda já foi mapeada historicamente, sem perder de vista que o principal produto é o DW, visto que a ideia é permitir às equipes um total domínio sobre os dados para que possam gerar suas próprias visualizações e soluções quando as demandas se apresentarem.

Uma evolução desejável passa pela atualização automática, que demandará uma permissão específica para acesso direto às bases de dados do SCAP, não sendo objetivo deste trabalho

### 2. Descrição das fontes de dados

Tabela 1. Fonte de dados 1 - Planilha Excel ‘Relatório Processos Recebidos/Enviados’ – 04 (quatro) relatórios  

![tabela1](https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/b2cf7dc9-46c2-43eb-8fe8-726b9e275fc4)

 
 
Tabela 2. Fonte de dados 2 - Planilha Excel ‘Relatório de processos produzidos no período selecionado’

![tabela2](https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/b6e95783-0f95-4554-8893-1afadbb2f071)

 
 
Tabela 3. Fonte de dados 3 - Planilha ‘Funcionários’

![tabela3](https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/547935a8-217f-435c-bd6d-bf4ed23cb70d)

 
 
### 3. Proposta de Processo BI

A partir da modelagem do problema a ser resolvido – que consiste basicamente de permitir a geração periódica de relatórios de produtividade, a partir dos relatórios incompletos e inconsistentes já existentes no sistema transacional – , pretende-se inicialmente elaborar a arquitetura do DW no Power Architect para receber os dados gerados por 07 (sete) planilhas do Excel que serão importadas, transformadas e carregadas pelo PDI no Postgres. A partir do DW estruturado, serão elaborados dashboards no PowerBI, conforme a figura a seguir:

 
 <div align="center">
<img src="https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/e0453062-c3f5-4a2c-8426-71564b465059" />
 
Figura 1. Modelagem BI.
</div>

### 4. Modelo Multidimensional

Esta seção apresenta o modelo estrela (star schema) do projeto Relatório de Produtividade elaborado no software Power Architect e carregado no Postgres.

<div align="center">
<img src="https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/ceef7303-3cf8-4fa3-99d2-c481cc3c26c3" /> 

Figura 2. Modelo Multidimensional.
</div>

### 5. Elaboração do Data Warehouse

O Data Warehouse será a fonte integradora de informações da empresa, a tecnologia será utilizada com o intuito de servir de base para a camada de aplicação que será responsável por fornecer dados para a tomada de decisão na organização. 

5.1. Arquitetura

Será utilizada arquitetura independente, devido ao curto espaço de tempo para implementação e em razão da necessidade do cliente.

5.2. Abordagem de Construção

Será feita abordagem Botom-Up devido aos seguintes fatores:
- rápida implementação, com foco no problema imediato de cada setor da organização;
- desejável empoderamento dos gestores setoriais na customização das soluções;
- histórico de soluções gerais eficientes e duradouras, quando implementadas a partir do entendimento e combinação das diferentes soluções setoriais, ao passo que a maioria das implementadas top-down ou são ineficientes ou caem em desuso rapidamente;
- alinhamento com a cultura geral da organização – no que se refere às auditorias governamentais, atividade fim da SGE.

5.3. Arquitetura Física

Será utilizada arquitetura física On-Premises devido aos seguintes fatores:
- simplicidade da solução
- solução setorial e de desejável possibilidade de customização setorial;
- impacto desprezível à estrutura já existente na empresa;
- inexistência de previsão de escalabilidade.

### 6. Projeto ETL

ETL01_PROCESSO:	Importou-se os 05 (cinco) relatórios individualizados por setor – que é o que o sistema gera; adicionou-se a coluna com o nome de cada setor e agrupou-se em uma única tabela; ajustou-se o número do processo para que ficasse igual aos das outras tabelas e servisse de chave estrangeira; criou-se uma coluna classificando melhor a natureza do processo para possibilitar relatórios mais úteis; incluiu-se uma sequência para servir de SK; excluiu-se os campos inúteis; tratou-se os campos nulos, tratou-se as strings; e exportou-se para a tabela dim_processos que havia sido criada no postgres pelo Powerarchitect. Adicionalmente gerou-se uma planilha excel também.


<div align="center">
<img src="https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/4dea7f1e-176f-46e3-99ce-e50527bedd0c" />

Figura 3. ETL01 – Dim.Processo.
</div>


ETL02_PRODUTIVIDADE:	Por fim, importou-se a tabela de produtividade que contém os processos assinados pelos funcionários; tratou-se o campo processo para servir de chave estrangeira; tratou-se o nome do setor; tratou-se o nome dos funcionários; incluiu-se uma sequência para servir de SK; excluiu-se os campos inúteis; e adicionou-se duas dimensões degeneradas da tabela funcionários para exportar para a tabela ft_produtividade no Postrgres, que havia sido criada no Powerarchitect.


<div align="center">
<img src="https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/11fcdded-09a2-4e32-b2be-6df762e212d2" />

Figura 4. ETL02 – FT.Produtividade.
</div>


Por fim, executou-se diretamente no Postgres um script SQL padronizado para popular a dimensão dim_data, que também foi criada no Power Architect.

### 7. Dashboards

7.1. Descrição da Elaboração
A visualização dos dados foi feita por meio do software PowerBI em conexão com o DW criado e populado no Postgres. 
Ainda houve a necessidade de alguma transformação, como a adição de colunas calculadas para servirem de contadores e colunas com tratamento de strings para diferenciar os processos que se referiam às esferas municipal e estadual, bem como os relativos às unidades gestoras de Prefeituras.

7.2. Telas do Dashboard

Dashboard 1: Trata-se de um visualizador rápido de produção por trimestre, de onde é possível retirar os resumos para o relatório trimestral.

<div align="center">
<img src="https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/d6f90c33-1cf8-4acc-8286-517ba59d2f65" />

Figura 5. Dashboard 1 - Processos.
</div>

Dashboard 2: Trata-se de um visualizador de produtividade por setor e por servidor. Considerando que cada setor possui quantitativo diferente de servidores e processos, criou-se uma coluna calculada para obtenção da quantidade de instruções processuais por servidor por setor. Incluiu-se também a evolução trimestral dessa produtividade.

<div align="center">
<img src="https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/58187b9e-5cbc-4004-b2a3-819a2df88200" />

Figura 6. Dashboard 2 - Produtividade.
</div>
 
Dashboard 3: Trata-se de uma visualização espacial, mostrando a quantidade de processos instruídos por prefeitura. Nesta visualização, fez-se a ressalva no botão informação de que se trata apenas dos processos referentes à UG Prefeitura, já que pode gerar confusão com as demais UGs municipais.

 <div align="center">
<img src="https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/2450ac8d-3583-4999-9345-8f92ef4dfa8e" />

Figura 7. Dashboard 3 - Prefeituras.
</div>
 
### 8. Conclusões

As ferramentas utilizadas para tratamento dos dados são completas e de fácil compreensão, mesmo se utilizadas apenas para transformações básicas, como no caso do presente projeto. No entanto, alguns erros inexplicáveis ocorreram.

Durante a montagem do fluxo de transformação ‘etl01_enviados’ no PDI, sempre que inserida uma das 4 estruturas de carregamento dos dados da planilha excel, a caixa ‘Microsoft Excel input’ apresentava o seguinte erro, no momento da seleção da planilha (sheet):

 <div align="center">
<img src="https://github.com/JorgeEduardo-Salles/Projeto-Final-2021.1/assets/79606219/90c0db6c-a0b8-474c-89cf-df0897559435" />

Figura 8. Erro observado durante a transformação.
</div>
 
Observou-se que inicialmente o erro se dava em razão do nome do arquivo conter o caractere ‘-‘ e que não bastava renomear pelo Windows, havendo necessidade de abrir o arquivo excel e salvá-lo com novo nome, sem o ‘-‘.

De toda forma, mesmo que não seja para popular um DW em um SGBD, o PDI se mostrou bastante eficiente para a transformação dos dados, podendo ser utilizado em larga escala para a atividade de auditoria, onde não há tempo nem interesse em estruturar bancos de dados, mas sim a transformação para rápido consumo, sendo que a possibilidade de documentação pelo fluxograma de transformação é uma vantagem adicional.

O PowerBI encerra tudo que de mais prático existe em visualização de dados. Entretanto, em alguns casos é interessante carregar o ETL em uma planilha para que seja utilizada pelo Excel, pois as análises exploratórias simples podem ser realizadas com mais elasticidade no caso das auditorias.


---

Matrícula: 211.100.514

Pontifícia Universidade Católica do Rio de Janeiro

Curso de Pós Graduação *Business Intelligence Master*
