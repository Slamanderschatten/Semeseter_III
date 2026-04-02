


CREATE PROCEDURE AddInteractionScript (
    IN p_typeName VARCHAR(128),
    IN p_scriptName VARCHAR(128),
    IN p_description VARCHAR(1024),
    IN p_scriptExists BOOLEAN,
    IN p_triggerNames VARCHAR128ARRAY
)
BEGIN
    DECLARE v_typeId INTEGER;
    DECLARE v_scriptId INTEGER;


    -- get type
    SELECT id INTO v_typeId
    FROM FLIPPERCOMPONENTTYPE
        WHERE NAME = p_typeName;
    -- prove id
    IF v_typeId IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'FlipperComponentType not exist';
    end if;


    -- interactionScript
    INSERT INTO INTERACTIONSCRIPT
        (TYPE, NAME, SCRIPTEXISTS, DESCRIPTION)
    VALUES
        (v_typeId, p_scriptName, p_scriptExists, p_description);
    SET v_scriptId = IDENTITY_VAL_LOCAL();


    -- add trigger
    DECLARE i INTEGER DEFAULT 1;
    DECLARE v_triggerName VARCHAR(128);
    DECLARE v_triggerId INTEGER;

    WHILE i <= CARDINALITY(p_triggerNames) DO
        SET v_triggerName = p_triggerNames[i];

        -- get trigger
        SELECT id INTO v_triggerId
        FROM INTERACTIONTRIGGER
            WHERE NAME = v_triggerName;
        -- prove id
        IF v_triggerId IS NULL THEN
            -- add trigger
            INSERT INTO INTERACTIONTRIGGER
                (NAME)
            VALUES
                (v_triggerName);
            SET v_triggerId = IDENTITY_VAL_LOCAL();
        end if;


        -- add trigger to interaction
        INSERT INTO EXISTINGTRIGGER
            (INTERACTIONTRIGGER, INTERACTIONSCRIPT)
        VALUES
            (v_triggerId, v_scriptId);

    end while;

end;