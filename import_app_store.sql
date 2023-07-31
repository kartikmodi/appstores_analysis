DROP TABLE IF EXISTS app_store_raw;
CREATE TABLE IF NOT EXISTS app_store_raw
(

    app_id                  text,
    app_name                text,
    appstore_url            text,
    primary_genre           text,
    content_rating          text,
    size_bytes              text,
    required_ios_version    text,
    released                text,
    updated                 timestamp,
    version                 text,
    price                   text,
    currency                text,
    free                    bool,
    developer_id            text,
    developer               text,
    developer_url           text,
    developer_website       text,
    average_user_rating     text,
    reviews                 bigint,
    current_version_score   float,
    current_version_reviews bigint

);
TRUNCATE app_store_raw;
COPY app_store_raw (appstore_url, app_id, app_name, average_user_rating,
                    content_rating, currency, current_version_reviews,
                    current_version_score, developer, developer_id,
                    developer_url, developer_website, free, price,
                    primary_genre, released, required_ios_version, reviews,
                    size_bytes, updated, version
    ) FROM
    PROGRAM 'curl -L "https://github.com/gauthamp10/apple-appstore-apps/raw/main/dataset/appleAppData.json.tar.lzma" --output - | tar -xv --lzma --to-stdout | jq -r ''(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv'''
    CSV HEADER;

CREATE TABLE app_store AS
SELECT app_id,
       app_name,
       appstore_url,
       primary_genre,
       content_rating,
       CASE WHEN size_bytes = '' THEN NULL
           ELSE size_bytes::bigint END as size_bytes,
       required_ios_version,
       CASE WHEN released = '' THEN NULL
           ELSE released::timestamp END as released,
       updated,
       version,
       price,
       currency,
       free,
       developer_id,
       developer,
       developer_url,
       developer_website,
       CASE WHEN average_user_rating = '' THEN NULL
           ELSE average_user_rating::float END as average_user_rating,
       reviews,
       current_version_score,
       current_version_reviews
        FROM app_store_raw;

SELECT *
from app_store
limit 100;