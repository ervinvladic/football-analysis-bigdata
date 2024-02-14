WITH SumYellowCards AS (
    -- Calculate total yellow cards and games played at home for each team
    SELECT
        HomeTeam AS Team,
        SUM(HomeYellowCards) AS TotalCards, -- Total yellow cards at home
        COUNT(*) AS Games -- Total games played at home
    FROM
        EnglishPremierLeague
    GROUP BY
        HomeTeam

    UNION ALL

    -- Calculate total yellow cards and games played away for each team
    SELECT
        AwayTeam AS Team,
        SUM(AwayYellowCards) AS TotalCards, -- Total yellow cards away
        COUNT(*) AS Games -- Total games played away
    FROM
        EnglishPremierLeague
    GROUP BY
        AwayTeam
)

-- Main query to calculate average yellow cards per game for each team
SELECT
    Team,
    AVG(CAST(TotalCards AS FLOAT) / Games) AS AverageYellowCardsPerGame -- Calculate average yellow cards per game
FROM
    SumYellowCards
GROUP BY
    Team; -- Group by team to get average yellow cards per game for each team

