use HiringEngine;

CREATE TABLE matches (
    candidate_id INT,
    job_id INT,
    skill_match_count INT,
    is_eligible BOOLEAN,
    PRIMARY KEY (candidate_id, job_id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(id),
    FOREIGN KEY (job_id) REFERENCES jobs(id)
);

SELECT
    c.id AS candidate_id,
    j.id AS job_id,
    c.name AS candidate_name,
    j.title AS job_title,
    JSON_LENGTH(
        JSON_ARRAYAGG(matched_skill)
    ) AS skill_match_count,
    CASE
        WHEN c.experience_years >= j.min_experience THEN TRUE
        ELSE FALSE
    END AS is_eligible
FROM
    candidates c
JOIN
    jobs j
JOIN
    JSON_TABLE(
        j.required_skills, '$[*]'
        COLUMNS (matched_skill VARCHAR(100) PATH '$')
    ) AS job_skill
JOIN
    JSON_TABLE(
        JSON_EXTRACT(c.resume_json, '$.skills'), '$[*]'
        COLUMNS (candidate_skill VARCHAR(100) PATH '$')
    ) AS resume_skill
ON
    job_skill.matched_skill = resume_skill.candidate_skill
GROUP BY
    c.id, j.id;

