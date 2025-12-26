from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import os
import random
import time

app = FastAPI(title="AI Product Description Service")

# Data Model
class ProductRequest(BaseModel):
    product_name: str
    keywords: list[str] = []

@app.get("/health")
def health_check():
    return {"status": "healthy", "service": "ai-service"}

@app.post("/generate")
def generate_description(request: ProductRequest):
    """
    Simulates a GenAI call. 
    In a real production app, you would call OpenAI/Bedrock here.
    For this demo, we mock it to save you money, but add a delay to simulate GPU latency.
    """
    
    # 1. Simulate Processing Time (AI is slow!)
    time.sleep(1.5) 
    
    # 2. Logic: Real or Mock?
    api_key = os.getenv("AI_API_KEY")
    
    adjectives = ["amazing", "revolutionary", "high-performance", "next-gen", "eco-friendly"]
    selected_adj = random.choice(adjectives)
    
    description = (
        f"Introducing the {selected_adj} {request.product_name}! "
        f"Designed for the modern user, this product combines {', '.join(request.keywords)} "
        "to deliver an unparalleled experience. Powered by AI."
    )

    return {
        "product": request.product_name,
        "description": description,
        "model_used": "gpt-4-turbo-mock",
        "processing_time": "1.5s"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)