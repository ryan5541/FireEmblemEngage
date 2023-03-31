USE master;
GO

USE FireEmblem;
GO

INSERT INTO [Character](Character_Name)
    SELECT DISTINCT [Character]
    FROM master.dbo.FireEmblem_Denormalized;

INSERT INTO [Class](Class_Name)
    SELECT DISTINCT [Class]
    FROM master.dbo.FireEmblem_Denormalized;

INSERT INTO [Stats](HP, Str, Mag, Dex, Spd, Def, Res, Lck, Bld, Rating)
    SELECT DISTINCT HP, Str, Mag, Dex, Spd, Def, Res, Lck, Bld, Rating
    FROM master.dbo.FireEmblem_Denormalized;

INSERT INTO [Stats_to_Character](Stats_ID, Character_ID, Class_ID)
    SELECT 
        S.Stats_ID,
        C.Character_ID,
        Cl.Class_ID
        From master.dbo.FireEmblem_Denormalized AS FE 
    INNER JOIN [Character] AS C ON FE.Character = C.Character_Name
    INNER JOIN [Class] AS Cl ON FE.Class = Cl.Class_Name
    INNER JOIN Stats AS S ON FE.HP = S.HP AND FE.Str = S.Str AND FE.Mag = S.Mag AND FE.Dex = S.Dex AND
        FE.Spd = S.Spd AND FE.Def = S.Def AND FE.Res = S.Res AND FE.Lck = S.Lck AND FE.Bld = S.Bld AND
        FE.Rating = S.Rating

-- Main view of data
SELECT C.Character_Name, Cl.Class_Name, 
S.HP, S.Str, S.Mag, S.Dex, S.Spd, S.Def, S.Res, S.Lck, S.Bld, S.Rating
FROM Stats_to_Character AS SC
INNER JOIN [Character] AS C ON SC.Character_ID = C.Character_ID
INNER JOIN Class AS Cl ON SC.Class_ID = Cl.Class_ID
INNER JOIN Stats AS S ON SC.Stats_ID = S.Stats_ID