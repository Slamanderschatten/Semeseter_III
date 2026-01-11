


CREATE PROCEDURE GetUsagesOfSound (
    IN p_soundName VARCHAR(128)
)
BEGIN
    SELECT
        cmp.name AS interactorName,
        i.name AS interactionName,
        t.name AS triggerName,
        isnd.implemented
    FROM SOUND s
    JOIN INTERACTIONSOUND isnd ON isnd.SOUND = s.ID
    JOIN BALLINTERACTION i ON i.ID = isnd.BALLINTERACTION
    JOIN INTERACTIONSCRIPT ii ON ii.ID = i.SCRIPT
    JOIN INTERACTIONTRIGGER t ON t.Id = ii.TYPE
    JOIN BALLINTERACTOR ior ON ior.FLIPPERCOMPONENT = i.INTERACTOR
    JOIN FLIPPERCOMPONENT cmp ON cmp.ID = ior.FLIPPERCOMPONENT
    WHERE s.NAME = p_soundName;
end;