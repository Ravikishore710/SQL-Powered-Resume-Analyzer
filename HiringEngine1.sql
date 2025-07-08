create database HiringEngine;
use HiringEngine;

CREATE TABLE candidates (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    resume_json JSON
);

INSERT INTO candidates VALUES (
    1,
    'Ravi',
    'ravi@example.com',
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
    '{
        "skills": ["React", "Node.js", "MongoDB", "Express", "Docker"],
        "certifications": ["Full Stack Developer Nanodegree"],
        "projects": [
            {"name": "E-commerce Platform", "stack": ["MERN", "JWT", "Redux"]},
            {"name": "CI/CD Deployment", "stack": ["Docker", "GitHub Actions"]}
        ]
    }'
);
select*from candidates;