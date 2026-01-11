



CREATE PROCEDURE AddSound (
    IN p_name VARCHAR(128),
    IN p_prepared BOOLEAN
)
BEGIN



    -- Sound
    INSERT INTO SOUND
        (NAME, PREPARED)
    VALUES
        (p_name, p_prepared);
end;