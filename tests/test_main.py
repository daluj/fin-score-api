from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_calculate_z_score():
    response = client.post("/calculate_z_score", json={
        "working_capital": 20000,
        "total_assets": 80000,
        "retained_earnings": 10000,
        "ebit": 15000,
        "total_liabilities": 50000,
        "book_value_equity": 30000
    })
    assert response.status_code == 200
    data = response.json()
    assert "Z-Score" in data
    assert "Status" in data
