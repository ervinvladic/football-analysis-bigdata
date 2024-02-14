WITH TeamGoalsReceived AS (
    -- Calculate total goals received and games played at home for each team
    SELECT
        HomeTeam AS Team,
        SUM(FTAG) AS TotalGoalsReceived, -- Total goals received at home
        COUNT(*) AS Games -- Total games played at home
    FROM
        EnglishPremierLeague
    GROUP BY
        HomeTeam

    UNION ALL

    -- Calculate total goals received and games played away for each team
    SELECT
        AwayTeam AS Team,
        SUM(FTHG) AS TotalGoalsReceived, -- Total goals received away
        COUNT(*) AS Games -- Total games played away
    FROM
        EnglishPremierLeague
    GROUP BY
        AwayTeam
)

-- Main query to calculate average goals received per game for each team
SELECT
    Team,
    AVG(CAST(TotalGoalsReceived AS FLOAT) / Games) AS AverageGoalsPerGame -- Calculate average goals received per game
FROM
    TeamGoalsReceived
GROUP BY
    Team; -- Group by team to get average goals received per game for each team




