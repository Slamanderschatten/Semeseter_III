


CREATE PROCEDURE GetUsagesOfScript (
    IN p_scriptName VARCHAR(128)
)
BEGIN
    SELECT
        cmp.name AS interactorName,
        i.name AS interactionName,
        i.scriptImplemented
    FROM INTERACTIONSCRIPT ii
    JOIN BALLINTERACTION i ON i.SCRIPT = ii.ID
    JOIN BALLINTERACTOR ior ON ior.FLIPPERCOMPONENT = i.INTERACTOR
    JOIN FLIPPERCOMPONENT cmp ON cmp.ID = ior.FLIPPERCOMPONENT
    WHERE ii.NAME = p_scriptName;
end;