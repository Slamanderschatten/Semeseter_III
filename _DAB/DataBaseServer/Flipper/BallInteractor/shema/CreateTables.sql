DROP TABLE IF EXISTS flipperComponentType;
DROP TABLE IF EXISTS interactionTrigger;
DROP TABLE IF EXISTS model;
DROP TABLE IF EXISTS flipperComponent;
DROP TABLE IF EXISTS ballInteractor;
DROP TABLE IF EXISTS flipperComponentInfo;
DROP TABLE IF EXISTS interactionImplementation;
DROP TABLE IF EXISTS ballInteraction;
DROP TABLE IF EXISTS existingTrigger;
DROP TABLE IF EXISTS sound;
DROP TABLE IF EXISTS interactionSound;


CREATE TABLE flipperComponentType (
    id  INTEGER NOT NULL,
    name    VARCHAR(128)  NOT NULL,
    description VARCHAR(1024) NOT NULL,

    CONSTRAINT pk_flipperComponentType PRIMARY KEY (id)
);


CREATE TABLE interactionTrigger (
    id  INTEGER NOT NULL,
    name    VARCHAR(128) NOT NULL,

    CONSTRAINT pk_interactionTrigger PRIMARY KEY (id)
);


CREATE TABLE model (
    id  INTEGER NOT NULL,
    name    VARCHAR(128) NOT NULL,
    integrated  BOOLEAN NOT NULL,

    CONSTRAINT pk_model PRIMARY KEY (id)
);


CREATE TABLE flipperComponent (
    id  INTEGER NOT NULL,
    name    VARCHAR(128) NOT NULL,
    model   INTEGER NOT NULL,
    prefabExists    BOOLEAN NOT NULL,
    maxRotationAngle    REAL NOT NULL ,

    CONSTRAINT pk_flipperComponent PRIMARY KEY (id)
);


CREATE TABLE ballInteractor (
    flipperComponent  INTEGER NOT NULL ,

    CONSTRAINT pk_ballInteractor PRIMARY KEY (flipperComponent),
    CONSTRAINT fk_flipperComponent FOREIGN KEY (flipperComponent) REFERENCES flipperComponent(id)
);


CREATE TABLE flipperComponentInfo (
    component INTEGER NOT NULL ,
    visibleName VARCHAR(128) NOT NULL ,
    description VARCHAR(1024) NOT NULL ,

    CONSTRAINT pk_flipperComponentInfo PRIMARY KEY (component),
    CONSTRAINT fk_flipperComponent FOREIGN KEY (component) REFERENCES flipperComponent(id)
);


CREATE TABLE interactionImplementation (
    id  INTEGER NOT NULL ,
    type    INTEGER NOT NULL ,
    name    VARCHAR(128)    NOT NULL ,
    scriptExists    BOOLEAN NOT NULL ,
    description VARCHAR(128)    NOT NULL ,

    CONSTRAINT pk_interactionImplementation PRIMARY KEY (id),
    CONSTRAINT pk_flipperComponentType FOREIGN KEY (type) REFERENCES flipperComponentType(id)
);


CREATE TABLE ballInteraction (
    implementation    INTEGER NOT NULL ,
    id  INTEGER NOT NULL ,
    interactor  INTEGER NOT NULL ,
    name    VARCHAR(128) NOT NULL ,
    description VARCHAR(1024) NOT NULL ,
    minSpeed    REAL NOT NULL ,
    necessaryCharacteristics    VARCHAR(64),

    CONSTRAINT pk_ballInteraction PRIMARY KEY (implementation, id),
    CONSTRAINT fk_implementation FOREIGN KEY (implementation) REFERENCES interactionImplementation(id),
    CONSTRAINT fk_interactor FOREIGN KEY (interactor) REFERENCES ballInteractor(flipperComponent)
);


CREATE TABLE existingTrigger (
    interactionTrigger  INTEGER NOT NULL ,
    interactionImplementation   INTEGER NOT NULL ,

    CONSTRAINT pk_existingTrigger PRIMARY KEY (interactionTrigger, interactionImplementation),
    CONSTRAINT fk_interactionTrigger FOREIGN KEY (interactionTrigger) REFERENCES interactionTrigger(id),
    CONSTRAINT fk_interactionImplementation FOREIGN KEY (interactionImplementation) REFERENCES interactionImplementation(id)
);


CREATE TABLE sound (
    id  INTEGER NOT NULL ,
    name    VARCHAR(128) NOT NULL ,
    prepared  BOOLEAN NOT NULL ,

    CONSTRAINT pk_sound PRIMARY KEY (id)
);


CREATE TABLE interactionSound (
    interactionImplementation INTEGER NOT NULL ,
    ballInteraction   INTEGER NOT NULL ,
    sound INTEGER NOT NULL ,
    interactionTrigger  INTEGER NOT NULL ,
    id  INTEGER NOT NULL ,
    implemented BOOLEAN NOT NULL ,

    CONSTRAINT pk_interactionSound PRIMARY KEY (interactionImplementation, ballInteraction, sound, interactionTrigger, id),
    CONSTRAINT fk_interaction FOREIGN KEY (interactionImplementation, ballInteraction) REFERENCES ballInteraction(implementation, id),
    CONSTRAINT fk_sound FOREIGN KEY (sound) REFERENCES sound(id),
    CONSTRAINT fk_interactionTrigger FOREIGN KEY (interactionTrigger) REFERENCES interactionTrigger(id)
);















