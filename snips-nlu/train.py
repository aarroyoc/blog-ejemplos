import io
import json
from snips_nlu import load_resources, SnipsNLUEngine

load_resources("es")

with io.open("dataset.json") as f:
    dataset = json.load(f)

engine = SnipsNLUEngine()

engine.fit(dataset)

engine_json = json.dumps(engine.to_dict())
with io.open("trained.json",mode="w") as f:
    f.write(engine_json)


