CREATE OR REPLACE VIEW play_store_3_cat AS
SELECT app_name,
       app_id,
       category,
       CASE
           WHEN
                   category IN
                   ('Action', 'Adventure', 'Arcade', 'Board', 'Card', 'Casino',
                    'Casual', 'Educational', 'Music', 'Puzzle', 'Racing',
                    'RolePlaying', 'Simulation', 'Sports', 'Strategy', 'Trivia',
                    'Word') then 'Game'
           WHEN category = 'Music & Audio' then 'Music'
           WHEN category = 'Health & Fitness' then 'Health'
           END AS category_mapped,
       rating,
       rating_count,
       installs,
       minimum_installs,
       maximum_installs,
       free,
       price,
       currency,
       size,
       CASE
           when size = 'Varies with device'
               THEN -1
           ELSE pg_size_bytes(replace(size, ',', '') || 'B')
           END as size_bytes,
       minimum_android,
       developer_id,
       developer_website,
       developer_email,
       released,
       last_updated,
       content_Rating,
       privacy_policy,
       ad_supported,
       in_app_purchases,
       editors_choice,
       scraped_time
from play_store;


CREATE OR REPLACE VIEW app_store_3_cat AS
SELECT app_id,
       app_name,
       appstore_url,
       primary_genre,
       CASE
           WHEN primary_genre = 'Games' then 'Game'
           WHEN primary_genre = 'Music' then 'Music'
           WHEN primary_genre = 'Health & Fitness' then 'Health'
           END AS category_mapped,
       content_rating,
       size_bytes,
       required_ios_version,
       released,
       updated,
       version,
       price,
       currency,
       free,
       developer_id,
       developer,
       developer_url,
       developer_website,
       average_user_rating,
       reviews,
       current_version_score,
       current_version_reviews
FROM app_store;

