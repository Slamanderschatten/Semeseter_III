


CREATE PROCEDURE GetBallInteractor (
    IN p_ballInteractorName VARCHAR(128)
)
BEGIN
    SELECT
        cmp.id,
        cmp.name,
        mod.name AS modelName,
        cmp.prefabExists,
        cmp.maxRotationAngle,
        visInf.name AS visibleName,
        visInf.description AS visibleDescription
    FROM BALLINTERACTOR bi
    JOIN FLIPPERCOMPONENT cmp ON bi.FLIPPERCOMPONENT = cmp.ID
    JOIN MODEL mod ON mod.ID = cmp.MODEL
    LEFT JOIN FLIPPERCOMPONENTVISIBLEINFO visInf ON cmp.ID = visInf.FLIPPERCOMPONENT
    WHERE cmp.name = p_ballInteractorName;
end;