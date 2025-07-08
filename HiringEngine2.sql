use HiringEngine;

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
