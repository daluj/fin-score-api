# API Reference

## Endpoints

### 1. Calculate Altman Z-Score
**POST** `/calculate_z_score`

#### Request Body (JSON):
```json
{
  "working_capital": 20000,
  "total_assets": 80000,
  "retained_earnings": 10000,
  "ebit": 15000,
  "total_liabilities": 50000,
  "book_value_equity": 30000
}
```

#### Response:
```json
{
  "Z-Score": 3.94,
  "Status": "Safe Zone (Financially Stable)"
}
