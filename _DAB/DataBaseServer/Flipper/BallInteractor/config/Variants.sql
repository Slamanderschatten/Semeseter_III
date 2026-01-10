

MERGE INTO flipperComponentType t
Using (
    VALUES
        (0, 'Bumper', 'bump the ball'),
        (1, 'Controllable', 'controllable from player when a ball is in the interactor area'),
        (2, 'Generator', 'generate balls or other interactors'),
        (3, 'Influencer', 'influence the ball as long as there is inside'),
        (4, 'Sensor', 'no ball action'),
        (5, 'CharChanger', 'changes the character of the ball'),
        (6, 'Connector', 'build a connection to an other connector'),
        (7, 'Connection', 'connects two or more connectors')
    ) s(id, name, description)
ON t.id = s.id
WHEN MATCHED THEN
    UPDATE SET
       NAME = s.name,
       DESCRIPTION = s.description
WHEN NOT MATCHED THEN
    INSERT
        (id, name, description)
    VALUES
        (s.id, s.name, s.description);
;


MERGE INTO interactionTrigger t
Using (
    VALUES
        (0, 'OnBallEnter'),
        (1, 'OnBallExit'),
        (2, 'OnBallPresent'),
        (3, 'OnActivate'),
        (4, 'OnReset')
    ) s(id, name)
ON t.id = s.id
WHEN MATCHED THEN
    UPDATE SET
       NAME = s.name
WHEN NOT MATCHED THEN
    INSERT
        (id, name)
    VALUES
        (s.id, s.name)
;











