use HiringEngine;
CREATE OR REPLACE VIEW ranked_matches_per_job AS
WITH skill_matches AS (
    SELECT
        c.id AS candidate_id,
        j.id AS job_id,
        c.name AS candidate_name,
        j.title AS job_title,
        COUNT(*) AS skill_match_count,
        c.experience_years,
        j.min_experience
    FROM
        candidates c
    CROSS JOIN
        jobs j
    JOIN
        JSON_TABLE(
            j.required_skills, '$[*]'
            COLUMNS (required_skill VARCHAR(100) PATH '$')
        ) AS job_skill
    JOIN
        JSON_TABLE(
            JSON_EXTRACT(c.resume_json, '$.skills'), '$[*]'
            COLUMNS (candidate_skill VARCHAR(100) PATH '$')
        ) AS resume_skill
        ON job_skill.required_skill = resume_skill.candidate_skill
    WHERE
        c.experience_years >= j.min_experience
    GROUP BY
        c.id, j.id
),
ranked AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY job_id
            ORDER BY skill_match_count DESC, experience_years DESC
        ) AS candidate_rank
    FROM skill_matches
)
SELECT * FROM ranked_matches_per_job WHERE candidate_rank <= 3;

