CREATE TABLE IF NOT EXISTS play_store
(
    app_name          text,
    app_id            text,
    category          text,
    rating            float,
    rating_count      int,
    installs          text,
    minimum_installs  BIGINT,
    maximum_installs  BIGINT,
    free              bool,
    price             float,
    currency          text,
    size              text,
    minimum_android   text,
    developer_id      text,
    developer_website text,
    developer_email   text,
    released          date,
    last_updated      date,
    content_Rating    text,
    privacy_policy    text,
    ad_supported      bool,
    in_app_purchases  bool,
    editors_choice    bool,
    scraped_time      timestamp
);

TRUNCATE play_store;

COPY play_store FROM
    PROGRAM 'curl -L "https://github.com/gauthamp10/Google-Playstore-Dataset/raw/main/dataset/Part1.csv.tar.gz" --output - | tar -xvz --to-stdout'
    CSV HEADER;

SELECT * from play_store limit 1000;