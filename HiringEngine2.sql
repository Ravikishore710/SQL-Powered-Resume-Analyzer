SELECT 
    id,
    name,
    matching_skills,
    RANK() OVER (ORDER BY matching_skills DESC) AS skill_rank
FROM (
    SELECT 
        id,
        name,
        COUNT(*) AS matching_skills
    FROM (
        SELECT 
            c.id,
            c.name,
            JSON_UNQUOTE(JSON_EXTRACT(resume_json, CONCAT('$.skills[', n.n, ']'))) AS skill
        FROM candidates c
        JOIN (
            SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION 
                   SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7
        ) n
        ON n.n < JSON_LENGTH(JSON_EXTRACT(c.resume_json, '$.skills'))
    ) AS extracted
    WHERE skill IN ('Python', 'TensorFlow', 'SQL', 'Docker', 'Excel', 'Power BI')
    GROUP BY id, name
) AS skill_matches
ORDER BY skill_rank;
