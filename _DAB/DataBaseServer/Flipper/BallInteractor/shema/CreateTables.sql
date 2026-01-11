DROP TABLE IF EXISTS flipperComponentType;
DROP TABLE IF EXISTS interactionTrigger;
DROP TABLE IF EXISTS model;
DROP TABLE IF EXISTS flipperComponent;
DROP TABLE IF EXISTS ballInteractor;
DROP TABLE IF EXISTS flipperComponentVisibleInfo;
DROP TABLE IF EXISTS interactionScript;
DROP TABLE IF EXISTS ballInteraction;
DROP TABLE IF EXISTS existingTrigger;
DROP TABLE IF EXISTS sound;
DROP TABLE IF EXISTS interactionSound;


CREATE TABLE flipperComponentType (
    id  INTEGER
          GENERATED ALWAYS AS IDENTITY ,
    name    VARCHAR(128)  NOT NULL,
    description VARCHAR(1024) NOT NULL,

    CONSTRAINT pk_flipperComponentType PRIMARY KEY (id),
    CONSTRAINT uq_flipperComponentTypeName UNIQUE (name)
);


CREATE TABLE interactionTrigger (
    id  INTEGER
        GENERATED ALWAYS AS IDENTITY ,
    name    VARCHAR(128) NOT NULL,

    CONSTRAINT pk_interactionTrigger PRIMARY KEY (id),
    CONSTRAINT uq_interactionTriggerName UNIQUE (name)
);


CREATE TABLE model (
    id  INTEGER
        GENERATED ALWAYS AS IDENTITY ,
    name    VARCHAR(128) NOT NULL,
    integrated  BOOLEAN NOT NULL,

    CONSTRAINT pk_model PRIMARY KEY (id),
    CONSTRAINT uq_modelName UNIQUE (name)
);


CREATE TABLE flipperComponent (
    id  INTEGER
        GENERATED ALWAYS AS IDENTITY ,
    name    VARCHAR(128) NOT NULL,
    model   INTEGER NOT NULL,
    prefabExists    BOOLEAN NOT NULL,
    maxRotationAngle    REAL NOT NULL ,

    CONSTRAINT pk_flipperComponent PRIMARY KEY (id),
    CONSTRAINT uq_flipperComponentName UNIQUE (name)
);


CREATE TABLE ballInteractor (
    flipperComponent  INTEGER NOT NULL ,

    CONSTRAINT pk_ballInteractor PRIMARY KEY (flipperComponent),
    CONSTRAINT fk_flipperComponent FOREIGN KEY (flipperComponent) REFERENCES flipperComponent(id)
);


CREATE TABLE flipperComponentVisibleInfo (
    flipperComponent INTEGER NOT NULL ,
    name VARCHAR(128) NOT NULL ,
    description VARCHAR(1024) NOT NULL ,

    CONSTRAINT pk_flipperComponentInfo PRIMARY KEY (flipperComponent),
    CONSTRAINT fk_flipperComponent FOREIGN KEY (flipperComponent) REFERENCES flipperComponent(id)
);


CREATE TABLE interactionScript (
    id  INTEGER
        GENERATED ALWAYS AS IDENTITY ,
    type    INTEGER NOT NULL ,
    name    VARCHAR(128)    NOT NULL ,
    scriptExists    BOOLEAN NOT NULL ,
    description VARCHAR(128)    NOT NULL ,

    CONSTRAINT pk_interactionScript PRIMARY KEY (id),
    CONSTRAINT pk_flipperComponentType FOREIGN KEY (type) REFERENCES flipperComponentType(id),
    CONSTRAINT uq_interactionScriptName UNIQUE (name)
);


CREATE TABLE ballInteraction (
    script    INTEGER NOT NULL ,
    id  INTEGER
        GENERATED ALWAYS AS IDENTITY ,
    interactor  INTEGER NOT NULL ,
    name    VARCHAR(128) NOT NULL ,
    description VARCHAR(1024) NOT NULL ,
    minSpeed    REAL NOT NULL ,
    necessaryCharacteristics    VARCHAR(256) NOT NULL ,
    scriptImplemented BOOLEAN NOT NULL ,

    CONSTRAINT pk_ballInteraction PRIMARY KEY (script, id),
    CONSTRAINT fk_script FOREIGN KEY (script) REFERENCES interactionScript(id),
    CONSTRAINT fk_interactor FOREIGN KEY (interactor) REFERENCES ballInteractor(flipperComponent)
);


CREATE TABLE existingTrigger (
    interactionTrigger  INTEGER NOT NULL ,
    interactionScript   INTEGER NOT NULL ,

    CONSTRAINT pk_existingTrigger PRIMARY KEY (interactionTrigger, interactionScript),
    CONSTRAINT fk_interactionTrigger FOREIGN KEY (interactionTrigger) REFERENCES interactionTrigger(id),
    CONSTRAINT fk_interactionScript FOREIGN KEY (interactionScript) REFERENCES interactionScript(id)
);


CREATE TABLE sound (
    id  INTEGER
        GENERATED ALWAYS AS IDENTITY ,
    name    VARCHAR(128) NOT NULL ,
    prepared  BOOLEAN NOT NULL ,

    CONSTRAINT pk_sound PRIMARY KEY (id),
    CONSTRAINT uq_soundName UNIQUE (name)
);


CREATE TABLE interactionSound (
    interactionScript INTEGER NOT NULL ,
    ballInteraction   INTEGER NOT NULL ,
    sound INTEGER NOT NULL ,
    interactionTrigger  INTEGER NOT NULL,
    implemented BOOLEAN NOT NULL ,

    CONSTRAINT pk_interactionSound PRIMARY KEY (interactionScript, ballInteraction, sound, interactionTrigger),
    CONSTRAINT fk_interaction FOREIGN KEY (interactionScript, ballInteraction) REFERENCES ballInteraction(script, id),
    CONSTRAINT fk_sound FOREIGN KEY (sound) REFERENCES sound(id),
    CONSTRAINT fk_interactionTrigger FOREIGN KEY (interactionTrigger) REFERENCES interactionTrigger(id)
);







DROP TYPE VARCHAR128ARRAY;
CREATE TYPE VARCHAR128ARRAY AS VARCHAR(128) ARRAY[];















