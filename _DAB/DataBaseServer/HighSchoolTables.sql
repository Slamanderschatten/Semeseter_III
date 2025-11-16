


CREATE TABLE person (
    persnr          INTEGER         NOT NULL,
    name            VARCHAR(40)     NOT NULL,
    vorname         VARCHAR(40)     NOT NULL,
    gebdat          DATE            NOT NULL,
    geschlecht      CHAR            NOT NULL,

    CONSTRAINT pk_person PRIMARY KEY (persnr),
);


CREATE TABLE adresse (
     persnr          INTEGER         NOT NULL,
     adressnr        INTEGER         NOT NULL,
     plz             INTEGER         NOT NULL,
     ort             VARCHAR(40)     NOT NULL ,
     strasse         VARCHAR(40)     NOT NULL,

     CONSTRAINT pk_adresse PRIMARY KEY (persnr, adressnr),
     CONSTRAINT fk_person FOREIGN KEY (persnr) REFERENCES person(persnr)
);


CREATE TABLE verkaeufer (
    persnr          INTEGER         NOT NULL,
    stellung        VARCHAR(20)     NOT NULL,
    eintrittsdat    DATE            NOT NULL,

    CONSTRAINT pk_verkaeufer PRIMARY KEY (persnr),
    CONSTRAINT fk_verkaeufernr FOREIGN KEY (persnr) REFERENCES person(persnr)
);


CREATE TABLE kunde (
    persnr          INTEGER         NOT NULL,
    verknr          INTEGER         NOT NULL ,

    CONSTRAINT pk_verkaeufer PRIMARY KEY (persnr),
    CONSTRAINT fk_kundennr FOREIGN KEY (persnr) REFERENCES person(persnr),
    CONSTRAINT fk_verknr FOREIGN KEY (persnr) REFERENCES verkaeufer(persnr)
);


CREATE TABLE bankverbindung (
    persnr          INTEGER         NOT NULL ,
    bankvnr         INTEGER         NOT NULL ,
    iban            VARCHAR(40)     NOT NULL ,
    bic             INTEGER         NOT NULL ,

    CONSTRAINT pk_bankverbindung PRIMARY KEY (persnr, bankvnr),
    CONSTRAINT fk_kontoinhaber FOREIGN KEY (persnr) REFERENCES person(persnr)
);


CREATE TABLE einkauf (
    persnr          INTEGER         NOT NULL ,
    einkaufnr       INTEGER         NOT NULL ,
    zeitpunkt       TIMESTAMP       NOT NULL ,
    zahlweg         VARCHAR(40)     NOT NULL ,
    bankvnr         INTEGER,
    verknr          INTEGER,

    CONSTRAINT pk_einkauf PRIMARY KEY (persnr, einkaufnr),
    CONSTRAINT fk_einkaeufer FOREIGN KEY (persnr) REFERENCES person(persnr),
    CONSTRAINT fk_bankv FOREIGN KEY (bankvnr) REFERENCES bankverbindung(bankvnr),
    CONSTRAINT fk_verkaeufer FOREIGN KEY (verknr) REFERENCES verkaeufer(persnr)
);


CREATE TABLE artikel (
    artikelnr       INTEGER         NOT NULL ,
    artname         VARCHAR(200)    NOT NULL ,
    kurzbeschr      VARCHAR(400),
    preis           INTEGER         NOT NULL,

    CONSTRAINT pk_artikel PRIMARY KEY (artikelnr)
);


CREATE TABLE artikelanzahl (
    persnr          INTEGER         NOT NULL ,
    einkaufnr       INTEGER         NOT NULL ,
    artikelnr       INTEGER         NOT NULL ,
    anzahl          INTEGER         NOT NULL
                           CONSTRAINT anzahl_min CHECK(anzahl >= 1),

    CONSTRAINT pk_artikelanzahl PRIMARY KEY (persnr, einkaufnr, artikelnr),
    CONSTRAINT fk_person FOREIGN KEY (persnr) REFERENCES einkauf(persnr),
    CONSTRAINT fk_einkauf FOREIGN KEY (einkaufnr) REFERENCES einkauf(einkaufnr),
    CONSTRAINT fk_artikel FOREIGN KEY (artikelnr) REFERENCES artikel(artikelnr),
);














