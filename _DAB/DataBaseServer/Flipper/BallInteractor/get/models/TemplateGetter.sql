

-- get all declared scripts
SELECT
    m.NAME,
    m.INTEGRATED
FROM MODEL m;


-- get prepared scripts
SELECT
    m.NAME
FROM MODEL m
WHERE m.INTEGRATED = TRUE;


-- get not prepared scripts
SELECT
    m.NAME
FROM MODEL m
WHERE m.INTEGRATED = FALSE;


-- get used scripts
SELECT DISTINCT
    m.NAME,
    m.INTEGRATED
FROM MODEL m
JOIN FLIPPERCOMPONENT cmp ON cmp.MODEL = m.ID;


-- get not used scripts
SELECT
    m.NAME,
    m.INTEGRATED
FROM MODEL m
LEFT JOIN FLIPPERCOMPONENT cmp ON cmp.MODEL = m.ID
WHERE cmp.MODEL IS NULL;


-- get missing scripts
SELECT DISTINCT
    m.NAME
FROM MODEL m
JOIN FLIPPERCOMPONENT cmp ON cmp.MODEL = m.ID
WHERE m.INTEGRATED = FALSE;