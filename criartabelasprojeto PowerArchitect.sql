
CREATE TABLE dim_data (
                sk_data INTEGER NOT NULL,
                nk_data DATE NOT NULL,
                desc_data_completa VARCHAR(60) NOT NULL,
                nr_ano INTEGER NOT NULL,
                nm_trimestre VARCHAR(20) NOT NULL,
                nr_ano_trimestre VARCHAR(20) NOT NULL,
                nr_mes INTEGER NOT NULL,
                nm_mes VARCHAR(20) NOT NULL,
                ano_mes VARCHAR(20) NOT NULL,
                nr_semana INTEGER NOT NULL,
                ano_semana VARCHAR(20) NOT NULL,
                nr_dia INTEGER NOT NULL,
                nr_dia_ano INTEGER NOT NULL,
                nm_dia_semana VARCHAR(20) NOT NULL,
                flag_final_semana CHAR(3) NOT NULL,
                flag_feriado CHAR(3) NOT NULL,
                nm_feriado VARCHAR(60) NOT NULL,
                dt_final TIMESTAMP NOT NULL,
                dt_carga TIMESTAMP NOT NULL,
                CONSTRAINT sk_data_pk PRIMARY KEY (sk_data)
);


CREATE TABLE dim_processo (
                sk_processo INTEGER NOT NULL,
                nk_processo VARCHAR(11) NOT NULL,
                andoc INTEGER NOT NULL,
                nmsetor VARCHAR(50) NOT NULL,
                nmnaturezaresumida VARCHAR(100) NOT NULL,
                dcgrnatureza VARCHAR(100) NOT NULL,
                dcnatureza VARCHAR(100) NOT NULL,
                nmorgao VARCHAR(100) NOT NULL,
                nminteressado VARCHAR(100) NOT NULL,
                txobservacao VARCHAR(255) NOT NULL,
                dctramita VARCHAR(20) NOT NULL,
                cdultimacarga INTEGER NOT NULL,
                cdpesquisa VARCHAR(100) NOT NULL,
                nrdocorigem VARCHAR(20) NOT NULL,
                dtcadastro DATE,
                CONSTRAINT sk_processo PRIMARY KEY (sk_processo)
);


CREATE TABLE ft_produtividade (
                sk_produtividade INTEGER NOT NULL,
                sk_processo INTEGER NOT NULL,
                sk_data INTEGER NOT NULL,
                nk_produtividade VARCHAR(30) NOT NULL,
                nmprocesso VARCHAR(11) NOT NULL,
                nmsetor VARCHAR(50) NOT NULL,
                nmfuncionario VARCHAR(200) NOT NULL,
                dtinformacao DATE NOT NULL,
                dtsaida DATE NOT NULL,
                nmatricula INTEGER NOT NULL,
                nmapelido VARCHAR(30) NOT NULL,
                CONSTRAINT sk_produtividade PRIMARY KEY (sk_produtividade, sk_processo, sk_data)
);


ALTER TABLE ft_produtividade ADD CONSTRAINT dim_data_ft_produtividade_fk
FOREIGN KEY (sk_data)
REFERENCES dim_data (sk_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE ft_produtividade ADD CONSTRAINT dim_processo_ft_produtividade_fk
FOREIGN KEY (sk_processo)
REFERENCES dim_processo (sk_processo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
