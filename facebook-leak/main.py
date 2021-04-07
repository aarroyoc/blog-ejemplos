from fastapi import FastAPI, Request
from fastapi.templating import Jinja2Templates
import aiohttp


app = FastAPI()
templates = Jinja2Templates(directory="templates")

session = aiohttp.ClientSession()


@app.get("/")
def index(request: Request):
    return templates.TemplateResponse("search.html", {"request": request, "hits": []})

@app.get("/search")
async def search(request: Request, name: str, surname: str):
    query = {
        "size": 100,
        "query": {
            "query_string": {
                "query": f"(name:{name} AND surname:{surname})",
            }
        }
    }

    async with session.get("http://localhost:9200/_search", json=query) as response:
        result = await response.json()

    return templates.TemplateResponse("search.html", {"request": request, "hits": result["hits"]["hits"]})

