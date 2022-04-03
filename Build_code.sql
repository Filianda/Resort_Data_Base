CREATE TABLE domek(
nazwa_domku CHAR(1) CONSTRAINT nazwa_dom_pk PRIMARY KEY,
metraz NUMBER(5,2),
max_ilosc_osob NUMBER DEFAULT 5 CONSTRAINT max_os_nn NOT NULL,
typ_brodzika VARCHAR2(15) DEFAULT 'gęboki' CONSTRAINT typ_brodz_nn NOT NULL,
czy_dwuskrzydlowe_drzwi CHAR(1) DEFAULT 'N' CONSTRAINT dzwi_nn NOT NULL,
CONSTRAINT drzwi_ch_yn CHECK( czy_dwuskrzydlowe_drzwi = 'T' OR czy_dwuskrzydlowe_drzwi = 'N' )
);
CREATE TABLE sypialnia(
ID_sypialni CHAR(3) CONSTRAINT id_sypialni_pk PRIMARY KEY,
nr_d CHAR(1),
Max_ilosc_spiacych NUMBER(2) DEFAULT 2 CONSTRAINT max_os_s_nn NOT NULL,
Czy_dla_dzieci CHAR(1) DEFAULT 'N' CONSTRAINT czy_dla_dzieci_ch_yn CHECK ( Czy_dla_dzieci = 'N' OR Czy_dla_dzieci = 'T' ),
CONSTRAINT sypialnia_domek_fk FOREIGN KEY (nr_d) REFERENCES domek(nazwa_domku)
);
CREATE TABLE lozko(
ID_lozka CHAR(3) CONSTRAINT id_lozka_pk PRIMARY KEY,
id_s CHAR(3),
Max_ilosc_lozek NUMBER(2) DEFAULT 1 CONSTRAINT max_os_l_nn NOT NULL,
Typ_lozka VARCHAR2(11) DEFAULT 'po-1/2' CONSTRAINT typ_lozka_ch CHECK ( Typ_lozka = 'pietrowe' OR Typ_lozka = 'dla dzieci' OR Typ_lozka
= 'po-1' OR Typ_lozka = 'po-2' OR Typ_lozka = 'po-1/2'),
CONSTRAINT lozko_sypialnia_fk FOREIGN KEY (id_s) REFERENCES sypialnia(ID_sypialni)
);
CREATE TABLE usterki(
ID_usterki CHAR(3) CONSTRAINT id_usterki_pk PRIMARY KEY,
Sposob_usuniecia VARCHAR2(100),
Czyja_wina VARCHAR2(100),
Data_u DATE CONSTRAINT data_u_nn NOT NULL,
Opis_u VARCHAR2 (1000),
Koszt_u NUMBER(15,2) CONSTRAINT koszt_u_nn NOT NULL
);
CREATE TABLE osoba(
ID_osoby CHAR(3) CONSTRAINT id_osoby_pk PRIMARY KEY,
Imie VARCHAR2(15) CONSTRAINT imie_nn NOT NULL,
Nazwisko VARCHAR2(30) CONSTRAINT nazwisko_nn NOT NULL,
Telefon CHAR(9),
Email VARCHAR2(100),
Czy_zdalna_praca CHAR(1) CONSTRAINT zdalniak_nn NOT NULL CONSTRAINT zdalniach_ch_yn CHECK( Czy_zdalna_praca = 'T' OR
Czy_zdalna_praca = 'N'),
Wynik_testu_COVID CHAR(1) DEFAULT '0' CONSTRAINT test_covid_nn NOT NULL CONSTRAINT test_covid_ch CHECK( Wynik_testu_COVID = '0'
OR Wynik_testu_COVID = '-' OR Wynik_testu_COVID = '+'),
Ostatni_wyjazd_za_granice DATE CONSTRAINT o_wyjazd_za_granice_nn NOT NULL,
Czy_kontakt_z_chorym VARCHAR2(100) CONSTRAINT czy_kontakt_chory_nn NOT NULL
);
CREATE TABLE pobyt(
ID_pobytu CHAR(3) CONSTRAINT id_pobytu_pk PRIMARY KEY,
Data_od DATE CONSTRAINT data_od_nn NOT NULL,
Data_do DATE,
Ile_aut NUMBER(1) DEFAULT 1 CONSTRAINT ile_aut_mm NOT NULL,
Ile_dzieci NUMBER(2) CONSTRAINT ile_dzieci_nn NOT NULL,
Ile_doroslych NUMBER(2) CONSTRAINT ile_doroslych_nn NOT NULL,
Czy_faktura CHAR(1) DEFAULT 'N' CONSTRAINT czy_faktura_nn NOT NULL CONSTRAINT czy_faktura_ch_yn CHECK( Czy_faktura = 'N' OR
Czy_faktura = 'T' ),
Stan_butli_gaz VARCHAR2(15) DEFAULT 'Brak zmiany' CONSTRAINT stan_gaz_nn NOT NULL,
Czy_dod_posciel CHAR(1) DEFAULT 'N' CONSTRAINT czy_dod_posciel_ch_yn CHECK ( Czy_dod_posciel = 'N' OR Czy_dod_posciel = 'T' ),
Wartosc_prad_start NUMBER(5,3) CONSTRAINT wartosc_prad_s_nn NOT NULL,
Wartosc_prad_stop NUMBER(5,3),
Wartosc_woda_start NUMBER(5,3) CONSTRAINT wartosc_h2o_s_nn NOT NULL,
Wartosc_woda_stop NUMBER(5,3),
Stan VARCHAR2(40) CONSTRAINT stan_nn NOT NULL CONSTRAINT stan_ch CHECK( Stan = 'zaplacone z zadatkiem' OR Stan = 'brak zaliczki'
OR Stan = 'zaliczka' OR Stan = 'oddany zadatek' ),
Zaliczka NUMBER(4,2) CONSTRAINT zaliczka_nn NOT NULL,
id_o CHAR(3),
nazw_d CHAR(1),
id_u CHAR (3),
CONSTRAINT ososba_pobyt_fk FOREIGN KEY (id_o) REFERENCES osoba(ID_osoby),
CONSTRAINT domek_pobyt_fk FOREIGN KEY (nazw_d) REFERENCES domek(nazwa_domku),
CONSTRAINT usterka_pobyt_fk FOREIGN KEY (id_u) REFERENCES usterki(ID_usterki)
);
CREATE TABLE licznik (
ID_licznika CHAR(3) CONSTRAINT id_licznika_pk PRIMARY KEY,
Typ_licznika CHAR(4) CONSTRAINT typ_l_nn NOT NULL CONSTRAINT typ_1_l_ch CHECK ( Typ_licznika = 'woda' OR Typ_licznika = 'prad' ),
Koszt_1_jedn NUMBER(3,2) CONSTRAINT koszt_1_jedn_nn NOT NULL,
Jednostka VARCHAR(40) CONSTRAINT jednostka_nn NOT NULL,
id_p CHAR(3),
CONSTRAINT pobyt_licznik_fk FOREIGN KEY (id_p) REFERENCES pobyt(ID_pobytu)
);
CREATE TABLE koszt_dodatkowy(
ID_kosztu CHAR(3) CONSTRAINT id_kosztu_pk PRIMARY KEY,
Typ_kosztu CHAR(4) CONSTRAINT typ_kosztu_nn NOT NULL CONSTRAINT typ_kosztu_ch CHECK ( Typ_kosztu = 'woda' OR Typ_kosztu = 'prad'
OR Typ_kosztu = 'inne' ),
Koszt_k NUMBER(12,2) CONSTRAINT koszt_k_nn NOT NULL,
Opis_k VARCHAR2(100),
id_p CHAR(3),
id_c CHAR(3),
CONSTRAINT pobyt_koszt_d_fk FOREIGN KEY (id_p) REFERENCES pobyt(ID_pobytu),
CONSTRAINT cena_koszt_d_fk FOREIGN KEY (id_c) REFERENCES cena(ID_ceny)
);
