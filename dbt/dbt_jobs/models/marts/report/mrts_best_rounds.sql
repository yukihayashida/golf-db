-- input: mrts_round_summary
WITH stg_mrts_round_summary AS (
    SELECT
        playid
        , play_date
        , stroke_total
    FROM
        {{ ref('mrts_round_summary') }}
)

-- play_dateの昇順で見たときに、その時点までの最小stroke_totalをbest_scoreとして取得し、
-- そのbest_scoreとstroke_totalが等しいplayidのみを抽出する
, best_rounds AS (
    SELECT
        playid
        , play_date
        , stroke_total
        , min(stroke_total) over (order by play_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as best_score

    FROM
        stg_mrts_round_summary

    QUALIFY
        best_score = stroke_total
)

-- ベストタイは削除したいので、一つ前のレコードを見て best_scoreと等しい場合は除外する
, deduplicated_best_rounds AS (
    SELECT
        playid
        , play_date
        , best_score
        , lag(best_score, 1) over (order by play_date) as previous_best_score
    FROM
        best_rounds
    QUALIFY
        best_score != previous_best_score OR previous_best_score IS NULL
)

-- output: mrts_best_rounds
SELECT
    playid
    , play_date
    , best_score
    -- 前回のplay_date（前レコード）との差分（日数）
    , DATE_DIFF(play_date, lag(play_date) over (order by play_date), DAY) as days_since_last_best
FROM
    deduplicated_best_rounds
