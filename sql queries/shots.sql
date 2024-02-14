WITH SumShots AS (
    -- Calculate total shots and games played at home for each team
    SELECT
        HomeTeam AS Team,
        SUM(HomeShots) AS TotalShots, -- Total shots at home
        COUNT(*) AS Games -- Total games played at home
    FROM
        EnglishPremierLeague
    GROUP BY
        HomeTeam

    UNION ALL

    -- Calculate total shots and games played away for each team
    SELECT
        AwayTeam AS Team,
        SUM(AwayShots) AS TotalShots, -- Total shots away
        COUNT(*) AS Games -- Total games played away
    FROM
        EnglishPremierLeague
    GROUP BY
        AwayTeam
)

-- Main query to calculate average shots per game for each team
SELECT
    Team,
    AVG(CAST(TotalShots AS FLOAT) / Games) AS AverageShotsPerGame -- Calculate average shots per game
FROM
    SumShots
GROUP BY
    Team; -- Group by team to get average shots per game for each team
