-- get all declared sounds
SELECT
    s.name,
    s.prepared
FROM SOUND s;


-- get prepared sounds
SELECT
    s.name
FROM SOUND s
WHERE s.PREPARED = TRUE;


-- get not prepared sounds
SELECT
    s.name
FROM SOUND s
WHERE s.PREPARED = FALSE;


-- get used sounds
SELECT DISTINCT
    s.name,
    s.prepared
FROM SOUND s
JOIN INTERACTIONSOUND isnd ON isnd.SOUND = s.ID;


-- get not used sounds
SELECT
    s.name,
    s.prepared
FROM SOUND s
LEFT JOIN INTERACTIONSOUND isnd ON isnd.SOUND = s.ID
WHERE isnd.SOUND IS NULL;


-- get missing sounds
SELECT DISTINCT
    s.name,
    s.prepared
FROM SOUND s
JOIN INTERACTIONSOUND isnd ON isnd.SOUND = s.ID
WHERE s.PREPARED = FALSE;











