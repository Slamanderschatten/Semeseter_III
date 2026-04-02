

MERGE INTO flipperComponentType t
Using (
    VALUES
        ('Bumper', 'bump the ball'),
        ('Controllable', 'controllable from player when a ball is in the interactor area'),
        ('Generator', 'generate balls or other interactors'),
        ('Influencer', 'influence the ball as long as there is inside'),
        ('Sensor', 'no ball action'),
        ('CharChanger', 'changes the character of the ball'),
        ('Connector', 'build a connection to an other connector'),
        ('Connection', 'connects two or more connectors')
    ) s(name, description)
ON t.name = s.name
WHEN MATCHED THEN
    UPDATE SET
       NAME = s.name,
       DESCRIPTION = s.description
WHEN NOT MATCHED THEN
    INSERT
        (name, description)
    VALUES
        (s.name, s.description);
;


MERGE INTO interactionTrigger t
Using (
    VALUES
        ('OnBallEnter'),
        ('OnBallExit'),
        ('OnBallPresent'),
        ('OnActivate'),
        ('OnReset')
    ) s(name)
ON t.name = s.name
WHEN MATCHED THEN
    UPDATE SET
       NAME = s.name
WHEN NOT MATCHED THEN
    INSERT
        (name)
    VALUES
        (s.name)
;











