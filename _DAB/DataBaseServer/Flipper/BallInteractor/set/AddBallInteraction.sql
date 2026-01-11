


CREATE PROCEDURE AddBallInteraction (
    IN p_scriptName VARCHAR(128),
    IN p_interactorName VARCHAR(128),
    IN p_interactionName VARCHAR(128),
    IN p_description VARCHAR(1024),
    IN p_necessaryCharacteristics VARCHAR(256),
    IN p_minSpeed REAL,
    IN p_scriptImplemented BOOLEAN
)
BEGIN
    DECLARE v_implId INTEGER;
    DECLARE v_interactorId INTEGER;


    -- get script
    SELECT id INTO v_implId
    FROM INTERACTIONSCRIPT
        WHERE NAME = p_scriptName;
    -- prove id
    IF v_implId IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'InteractionScript not exist';
    end if;


    -- get Interactor
    -- get Flipper Component
    SELECT id INTO v_interactorId
    FROM FLIPPERCOMPONENT
    WHERE NAME = p_interactorName;
    -- prove id
    IF v_implId IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'BallInteractor not exist';
    end if;
    -- prove for type Interactor
    IF NOT EXISTS (
        SELECT 1
        FROM BALLINTERACTOR
        WHERE FLIPPERCOMPONENT = v_interactorId
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Flipper Component exists but is not an Ball Interactor';
    end if;


    -- add interaction
    INSERT INTO BALLINTERACTION
        (SCRIPT, INTERACTOR, NAME, DESCRIPTION, MINSPEED, NECESSARYCHARACTERISTICS, SCRIPTIMPLEMENTED)
    VALUES
        (v_implId, v_interactorId, p_interactionName,
         p_description, p_minSpeed, p_necessaryCharacteristics,
         p_scriptImplemented);

end;