# Appstore Data Analysis

The project is SQL only in Pg.

## Requirements

- Postgres. Tested on version 15.3
- jq - json cli utility
- psql (tested with) - i psql but I have not used any import on client side, so
  everything should work from any client.
- Internet connection - For getting datasets

## How to run (Order)

1. Imports - APP Store specific data cases are to be handled here.
    1. [import_play_store](./import_app_store.sql) for importing play store
       dataset.
    2. [import_app_store](./import_app_store.sql) for importing app store
       dataset.
2. Catalog - [catalog_base_views.sql](./catalog_base_views.sql) consists of base
   views. These are based on the scope of the problem.
   Future changes to scope should update these views.
3. Analysis - [analysis_queries](./analysis_queries.sql) contains the analysis
   queries for specific requirements.