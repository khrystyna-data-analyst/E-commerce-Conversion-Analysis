--CREATE OR REPLACE VIEW final-project-da-481119.final.full_data AS

WITH
-- sessions for filters and slices (only session_start)
sessions AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS session_id,
    user_pseudo_id || CAST((SELECT value.int_value
                            FROM UNNEST(event_params)
                            WHERE key = 'ga_session_id') AS STRING)
    AS user_session_id,
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS session_start_date,
    -- зрізи для дашборду:
    REGEXP_EXTRACT((SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'), r'(?:https:\/\/)?[^\/]+\/(.*)') AS landing_page_location,

    traffic_source.source AS source,
    traffic_source.medium AS medium,
    traffic_source.name   AS campaign,

    device.category       AS device_category,
    device.language       AS device_language,
    device.operating_system AS device_os,
    
    geo.country           AS country

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE event_name = 'session_start'
),
-- for the funnel
funnel_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS session_id,
    user_pseudo_id || CAST((SELECT value.int_value
                            FROM UNNEST(event_params)
                            WHERE key = 'ga_session_id') AS STRING)
    AS user_session_id,
    TIMESTAMP_MICROS(event_timestamp) AS event_ts,
    event_name
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE event_name IN (
    'session_start',
    'view_item',
    'add_to_cart',
    'begin_checkout',
    'add_shipping_info',
    'add_payment_info',
    'purchase'
  )
)
-- cсновний запит
SELECT
  s.user_session_id,
  s.user_pseudo_id,
  s.session_id,
  s.session_start_date,

  s.landing_page_location,

  s.source,
  s.medium,
  s.campaign,
  s.device_category,
  s.device_os,
  s.device_language,
  s.country,

  fe.event_name,
  fe.event_ts

FROM sessions s
LEFT JOIN funnel_events fe
  USING (user_session_id)
