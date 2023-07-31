-- DROP VIEW cat_3_analysis;
CREATE OR REPLACE TEMP VIEW cat_3_analysis AS
(
SELECT category_mapped,
       size_bytes,
       average_user_rating as rating,
       reviews             as rating_count,
       released,
       'app_store'            store_source
from app_store_3_cat
UNION ALL
SELECT category_mapped,
       size_bytes,
       rating,
       rating_count,
       released,
       'play_store' store_source
from play_store_3_cat);

-- 1
SELECT count(*), category_mapped, store_source
from cat_3_analysis
where category_mapped is not null
group by store_source, category_mapped
order by 3, 2;


-- 2
SELECT SUM(rating * rating_count) / SUM(rating_count) as avg_cat_ratings,
       category_mapped,
       store_source
from cat_3_analysis
where category_mapped is not null
group by store_source, category_mapped
order by 3, 2;

-- 3

SELECT count(*),
       category_mapped,
       to_char(released, 'YYYY-MM') as year_month,
       store_source
from cat_3_analysis
where category_mapped is not null
  and released is not null
group by store_source, category_mapped, year_month
order by store_source, year_month desc;

---4

SELECT category_mapped, size, store_source
from (SELECT row_number()
             over (PARTITION BY store_source,category_mapped ORDER BY size_bytes desc) as rnum
           , category_mapped
           , pg_size_pretty(size_bytes)                                                as size
           , store_source
      from cat_3_analysis
      where category_mapped is not null
        and size_bytes is not null) as w
where rnum <= 10
order by store_source, category_mapped, size desc

