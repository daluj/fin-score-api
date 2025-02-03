from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class FinancialData(BaseModel):
    working_capital: float # Current Assets - Current Liabilities
    total_assets: float # Cash, Inventory, Equipment, etc.
    retained_earnings: float # Profits reinvested into the business
    ebit: float # Earnings Before Interest & Taxes = Gross Profit - Operating Expenses
    total_liabilities: float # Short-term and long-term debts
    book_value_equity: float # Owner's investment + Retained earnings

def calculate_altman_z(data: FinancialData):
    # Compute financial ratios
    X1 = data.working_capital / data.total_assets # Measures Liquidity
    X2 = data.retained_earnings / data.total_assets # Indicates profitability & Reinvestment
    X3 = data.ebit / data.total_assets # Represents earning power of assets
    X4 = data.book_value_equity / data.total_liabilities # Shows financial leverage
    
    # Altman Z-Score Formula for private businesses
    Z_score = (6.56 * X1) + (3.26 * X2) + (6.72 * X3) + (1.05 * X4)
    
    # Interpretation of results
    if Z_score > 2.90:
        status = "Safe Zone (Financially Stable)"
        decisions = [
            "Continue with current operations",
            "Consider Business expansion or opening new branches",
            "Invest in marketing and branding for further growth",
            "Strengthen supplier relationships for cost reductions"
        ]
    elif 1.23 < Z_score < 2.90:
        status = "Gray Zone (Moderate Risk)"
        decisions = [
            "Reduce unnecessary expenses and overhead costs",
            "Improve efficiency in operations and inventory management",
            "Increase sales and marketing efforts",
            "Explore new business opportunities or partnerships",
            "Improve liquidity by increasing working capital",
            "Reduce liabilities and focus on debt repayment",
            "Increase retained earnings by reducing unnecessary expenses",
            "Boost EBIT by optimizing pricing and inventory management."
        ]
    else:
        status = "Distress Zone (High Risk of Bankruptcy)"
        decisions = [
            "Reduce fixed costs and operating expenses",
            "Negotiate with creditors for debt restructuring",
            "Explore debt refinancing or consolidation options",
            "Seek professional advice for turnaround and recovery",
            "Improve liquidity by increasing working capital",
            "Reduce liabilities and focus on debt repayment",
            "Increase retained earnings by reducing unnecessary expenses",
            "Boost EBIT by optimizing pricing and inventory management."
        ]
    
    return {"Z-Score": round(Z_score, 2), "Status": status, "Decisions": decisions}

@app.post("/calculate_z_score")
def calculate_z_score_api(data: FinancialData):
    result = calculate_altman_z(data)
    return result

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, debug=True)