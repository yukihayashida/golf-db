# golf-db

## 概要

ゴルフに関するスコアを分析可能な基盤を作る。

### 入力データは2つ
- スコアデータ
  - GDO + スコアカードの情報をGoogle Sheetsに蓄積。
- スイングデータ
  - 計測器で計測したデータを取得。
  - 計測器は主に2つ。
    - VC SC300
    - Garmin Approach R10
    
### 構成
 
- DataSource
 - Google Sheets
 - CSV at Google Drive
- DWH
 - Google BigQuery
- ELT
 - dbt (CLI)
- Workflow
 - Cloud Run
- BI / Analytics
 - Goolgl Dataportal

※極力無料でやりたい
