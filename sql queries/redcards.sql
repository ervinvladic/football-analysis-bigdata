WITH SumRedCards AS (
    -- Calculate total red cards and games played at home for each team
    SELECT
        HomeTeam AS Team,
        SUM(HomeRedCards) AS TotalCards, -- Total red cards at home
        COUNT(*) AS Games -- Total games played at home
    FROM
        EnglishPremierLeague
    GROUP BY
        HomeTeam

    UNION ALL

    -- Calculate total red cards and games played away for each team
    SELECT
        AwayTeam AS Team,
        SUM(AwayRedCards) AS TotalCards, -- Total red cards away
        COUNT(*) AS Games -- Total games played away
    FROM
        EnglishPremierLeague
    GROUP BY
        AwayTeam
)

-- Main query to calculate average red cards per game for each team
SELECT
    Team,
    AVG(CAST(TotalCards AS FLOAT) / Games) AS AverageRedCardsPerGame -- Calculate average red cards per game
FROM
    SumRedCards
GROUP BY
    Team; -- Group by team to get average red cards per game for each team
