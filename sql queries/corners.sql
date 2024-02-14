WITH TeamTotalCorners AS (
    -- Calculate total corners and games played at home for each team
    SELECT
        HomeTeam AS Team,
        SUM(HomeCorners) AS TotalCorners, -- Total corners at home
        COUNT(*) AS Games -- Total games played at home
    FROM
        EnglishPremierLeague
    GROUP BY
        HomeTeam

    UNION ALL

    -- Calculate total corners and games played away for each team
    SELECT
        AwayTeam AS Team,
        SUM(AwayCorners) AS TotalCorners, -- Total corners away
        COUNT(*) AS Games -- Total games played away
    FROM
        EnglishPremierLeague
    GROUP BY
        AwayTeam
)

-- Main query to calculate average corners per game for each team
SELECT
    Team,
    AVG(CAST(TotalCorners AS FLOAT) / Games) AS AverageCornersPerGame -- Calculate average corners per game
FROM
    TeamTotalCorners
GROUP BY
    Team; -- Group by team to get average corners per game for each team
