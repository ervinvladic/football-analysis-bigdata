WITH SumShotsOnTarget AS (
    -- Calculate total shots on target and games played at home for each team
    SELECT
        HomeTeam AS Team,
        SUM(HomeShotsOnTarget) AS TotalShotsOnTarget, -- Total shots on target at home
        COUNT(*) AS Games -- Total games played at home
    FROM
        EnglishPremierLeague
    GROUP BY
        HomeTeam

    UNION ALL

    -- Calculate total shots on target and games played away for each team
    SELECT
        AwayTeam AS Team,
        SUM(AwayShotsOnTarget) AS TotalShotsOnTarget, -- Total shots on target away
        COUNT(*) AS Games -- Total games played away
    FROM
        EnglishPremierLeague
    GROUP BY
        AwayTeam
)

-- Main query to calculate average shots on target per game for each team
SELECT
    Team,
    AVG(CAST(TotalShotsOnTarget AS FLOAT) / Games) AS AverageShotsOnTargetPerGame -- Calculate average shots on target per game
FROM
    SumShotsOnTarget
GROUP BY
    Team; -- Group by team to get average shots on target per game for each team
