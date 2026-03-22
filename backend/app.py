from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/")
def root():
    return {"service": "backend"}

@app.get("/env")
def env():
    return {"env": os.getenv("ENVIRONMENT")}
