

CREATE PROCEDURE AddBallInteractor (
    IN p_componentName VARCHAR(128),
    IN p_visibleComponentName VARCHAR(128),
    IN p_componentDescription VARCHAR(1024),
    IN p_maxRotationAngle REAL,
    IN p_prefabExists BOOLEAN,
    IN p_modelIntegrated BOOLEAN
)
BEGIN
    DECLARE v_modelId INTEGER;
    DECLARE v_componentId INTEGER;


    -- Model
    INSERT INTO model
        (name, integrated)
    VALUES
        (p_componentName, p_modelIntegrated);
    SET v_modelId = IDENTITY_VAL_LOCAL();


    -- Flipper Component
    INSERT INTO flipperComponent
        (NAME, MODEL, PREFABEXISTS, MAXROTATIONANGLE)
    VALUES
        (p_componentName, v_modelId, p_prefabExists, p_maxRotationAngle);
    SET v_modelId = IDENTITY_VAL_LOCAL();


    -- Flipper Component Info
    INSERT INTO FLIPPERCOMPONENTVISIBLEINFO
        (FLIPPERCOMPONENT, NAME, DESCRIPTION)
    VALUES
        (v_componentId, p_visibleComponentName, p_componentDescription);


    -- Ball Interactor
    INSERT INTO BALLINTERACTOR
        (FLIPPERCOMPONENT)
    VALUES
        (v_componentId);
end;