use HiringEngine;

CREATE TABLE candidates (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    experience_years INT,
    resume_json JSON
);

INSERT INTO candidates VALUES (
    1,
    'Ravi',
    'ravi@example.com',
    4,
    '{
        "skills": ["Python", "TensorFlow", "SQL", "Pandas", "Keras", "Docker"],
        "certifications": ["TensorFlow Developer Certificate"],
        "projects": [
            {"name": "Voice Assistant", "stack": ["Whisper", "Flask", "NLP"]},
            {"name": "Resume Ranker", "stack": ["PostgreSQL", "JSON", "CTE"]}
        ]
    }'
);

-- Candidate 2: Ram
INSERT INTO candidates VALUES (
    2,
    'Ram',
    'ram@example.com',
    3,
    '{
        "skills": ["Python", "BERT", "SpaCy", "Transformers", "NLTK"],
        "certifications": ["Hugging Face NLP Certificate"],
        "projects": [
            {"name": "Text Summarizer", "stack": ["BERT", "Flask", "Streamlit"]},
            {"name": "Chatbot", "stack": ["Dialogflow", "FastAPI"]}
        ]
    }'
);

-- Candidate 3: Arjun
INSERT INTO candidates VALUES (
    3,
    'Arjun',
    'arjun@example.com',
    3,
    '{
        "skills": ["Python", "OpenCV", "YOLOv5", "CNN", "Keras"],
        "certifications": ["Computer Vision with PyTorch"],
        "projects": [
            {"name": "Helmet Detection", "stack": ["YOLO", "Flask", "CV2"]},
            {"name": "OCR Engine", "stack": ["Tesseract", "OpenCV", "Streamlit"]}
        ]
    }'
);

-- Candidate 4: Kishore
INSERT INTO candidates VALUES (
    4,
    'Kishore',
    'kishore@example.com',
    5,
    '{
        "skills": ["SQL", "Tableau", "Power BI", "ETL", "Python"],
        "certifications": ["Tableau Analyst", "Power BI Specialist"],
        "projects": [
            {"name": "Sales Dashboard", "stack": ["Tableau", "SQL Server"]},
            {"name": "ETL Pipeline", "stack": ["Airflow", "PostgreSQL"]}
        ]
    }'
);

-- Candidate 5: Mahendra
INSERT INTO candidates VALUES (
    5,
    'Mahendra',
    'mahendra@example.com',
    2,
    '{
        "skills": ["Excel", "Power BI", "Pivot Tables", "VBA"],
        "certifications": ["Excel Expert 2019", "DA-100"],
        "projects": [
            {"name": "Retail Report", "stack": ["Excel", "Power BI"]},
            {"name": "Automation Scripts", "stack": ["VBA", "Macros"]}
        ]
    }'
);

-- Candidate 6: Mukesh
INSERT INTO candidates VALUES (
    6,
    'Mukesh',
    'mukesh@example.com',
    4,
    '{
        "skills": ["React", "Node.js", "MongoDB", "Express", "Docker"],
        "certifications": ["Full Stack Developer Nanodegree"],
        "projects": [
            {"name": "E-commerce Platform", "stack": ["MERN", "JWT", "Redux"]},
            {"name": "CI/CD Deployment", "stack": ["Docker", "GitHub Actions"]}
        ]
    }'
);

CREATE TABLE jobs (
    id INT PRIMARY KEY,
    title VARCHAR(100),
    company VARCHAR(100),
    min_experience INT,
    required_skills JSON
);

INSERT INTO jobs VALUES (
    1,
    'Data Scientist',
    'QuantWorks',
    3,
    '["Python", "TensorFlow", "SQL", "Docker"]'
);

INSERT INTO jobs VALUES (
    2,
    'NLP Research Engineer',
    'VoiceAI Labs',
    2,
    '["Python", "Transformers", "Hugging Face", "Flask"]'
);

INSERT INTO jobs VALUES (
    3,
    'CV Engineer',
    'VisionStack',
    3,
    '["OpenCV", "YOLO", "Python", "Flask"]'
);

INSERT INTO jobs VALUES (
    4,
    'Data Analyst',
    'MarketPulse',
    2,
    '["Excel", "Power BI", "SQL"]'
);

INSERT INTO jobs VALUES (
    5,
    'Full Stack Developer',
    'CodeForge',
    3,
    '["React", "Node.js", "MongoDB", "Docker"]'
);

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


