WITH TeamGoalsScored AS (
    -- Subquery to calculate total goals scored by each team
    SELECT
        Team,
        SUM(TotalGoals) AS TotalGoals, -- Total goals scored by the team
        COUNT(*) AS Games -- Total games played by the team
    FROM (
        -- Subquery to get goals scored by the home team
        SELECT
            HomeTeam AS Team,
            FTHG AS TotalGoals -- Total goals scored by the home team
        FROM
            EnglishPremierLeague

        UNION ALL

        -- Subquery to get goals scored by the away team
        SELECT
            AwayTeam AS Team,
            FTAG AS TotalGoals -- Total goals scored by the away team
        FROM
            EnglishPremierLeague
    ) AS GoalsPerTeam
    GROUP BY
        Team -- Group by team to calculate total goals and games
)

-- Main query to calculate average goals scored per game for each team
SELECT
    Team,
    AVG(CAST(TotalGoals AS FLOAT) / Games) AS AverageGoalsPerGame -- Calculate average goals per game
FROM
    TeamGoalsScored
GROUP BY
    Team; -- Group by team to get average goals per game for each team

