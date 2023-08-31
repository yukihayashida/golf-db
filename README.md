# golf-db

## 概要

ゴルフに関するスコアを分析可能な基盤を作る。

### 入力データは2つ
- スコアデータ
  - GDO + スコアカードの情報をGoogle Sheetsに蓄積。
- スイングデータ （※未対応）
  - 計測器で計測したデータを取得。
  - 計測器は主に2つ。
    - VC SC300
    - Garmin Approach R10
    
### 構成
 
- DataSource
  - Google Sheets
- DWH
  - Google BigQuery
- ELT
  - dbt (core)
- Workflow
  - Cloud Run
  - Cloud Scheduler （毎週月曜更新）
- BI / Analytics （※未対応）
  - Goolgl Dataportal
  - Cube Dev
  - streamlit

※極力無料でやりたい
