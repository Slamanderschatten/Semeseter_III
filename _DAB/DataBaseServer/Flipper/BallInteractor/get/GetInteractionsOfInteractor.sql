


CREATE PROCEDURE GetInteractionsOfInteractor (
    IN p_interactorId INTEGER
)
    DYNAMIC RESULT SETS 2
BEGIN
    DECLARE c_interactions CURSOR WITH RETURN FOR
        SELECT
            i.name,
            i.description,
            ct.name,
            ii.name AS scriptName,
            ii.description AS scriptDescription,
            i.minSpeed,
            i.necessaryCharacteristics,
            ii.scriptExists
        FROM BALLINTERACTOR ior
        JOIN BALLINTERACTion i ON ior.FLIPPERCOMPONENT = i.INTERACTOR
        JOIN INTERACTIONSCRIPT ii ON i.SCRIPT = ii.ID
        JOIN FLIPPERCOMPONENTTYPE ct ON ii.TYPE = ct.ID
        WHERE ior.FLIPPERCOMPONENT = p_interactorId;

    DECLARE  c_sounds CURSOR WITH RETURN FOR
        SELECT
            s.name
        FROM BALLINTERACTOR ior
        JOIN BALLINTERACTION i ON ior.FLIPPERCOMPONENT = i.INTERACTOR
        JOIN INTERACTIONSOUND is ON is.BALLINTERACTION = i.ID
        JOIN SOUND s ON s.ID = is.SOUND
        WHERE ior.FLIPPERCOMPONENT = p_interactorId;


    OPEN c_interactions;
    OPEN c_sounds;
end;