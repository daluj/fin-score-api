# Financial Score API

## Project Overview
This project is the first step in developing a comprehensive financial analysis tool for businesses. It provides an API to calculate the **Altman Z-Score**, a financial metric used to assess a company's risk of bankruptcy. The API is built using **FastAPI**, a high-performance web framework for Python.

## Features
- Accepts financial input data via a **POST** request.
- Computes the **Altman Z-Score** dynamically.
- Returns the financial health classification (Safe Zone, Gray Zone, or Distress Zone).
- Designed to be extended with more financial metrics in future updates.

## Installation
To use this API, you need **Python 3.8+** installed. Follow these steps to set up the project:

```bash
# Clone the repository
git clone https://github.com/your-username/altman-z-score-api.git
cd altman-z-score-api

# Create a virtual environment
python -m venv venv
source venv/bin/activate  # On Windows use: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

## Running the API
Start the FastAPI server with **Uvicorn**:

```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

The API will be accessible at:
- **Docs:** [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)
- **Alternative UI:** [http://127.0.0.1:8000/redoc](http://127.0.0.1:8000/redoc)

## Usage
Send a **POST** request to `/calculate_z_score` with JSON data:

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

### Sample Response
```json
{
  "Z-Score": 3.94,
  "Status": "Safe Zone (Financially Stable)"
}
```

## Roadmap
This project is the foundation for a broader financial analytics platform. Future updates will include:
- Additional financial metrics for business analysis.
- Integration with databases for persistent data storage.
- Visualization dashboards.

## Contributing
Feel free to fork this repository, submit issues, or contribute with pull requests!
