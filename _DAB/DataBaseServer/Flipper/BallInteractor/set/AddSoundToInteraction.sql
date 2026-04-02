


CREATE PROCEDURE AddSoundToInteraction (
    IN p_soundName VARCHAR(128),
    IN p_ballInteractionName VARCHAR(128),
    IN p_triggerName VARCHAR(128),
    IN p_implemented BOOLEAN
)
BEGIN
    DECLARE v_soundId INTEGER;
    DECLARE v_scriptId INTEGER;
    DECLARE v_interactionId INTEGER;
    DECLARE v_triggerId INTEGER;


    -- get sound
    SELECT id INTO v_soundId
    FROM SOUND
        WHERE NAME = p_soundName;
    -- prove id
    IF v_soundId IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Sound not exist';
    end if;


    -- get Ball Interaction
    SELECT SCRIPT, ID INTO v_scriptId, v_interactionId
    FROM BALLINTERACTION
    WHERE NAME = p_ballInteractionName;
    -- prove id
    IF v_soundId IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ball Interaction not exist';
    end if;


    -- get Trigger
    SELECT id INTO v_triggerId
    FROM INTERACTIONTRIGGER
    WHERE NAME = p_triggerName;
    -- prove id
    IF v_triggerId IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Trigger not exist';
    end if;


    -- Add Interaction-Sound
    INSERT INTO INTERACTIONSOUND
        (INTERACTIONSCRIPT, BALLINTERACTION, SOUND, INTERACTIONTRIGGER, IMPLEMENTED)
    VALUES
        (v_scriptId, v_interactionId, v_soundId,
         v_triggerId, p_implemented);






end;