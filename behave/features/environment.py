class WebClient:
    def __init__(self):
        pass
    def stop(self):
        pass

def before_all(context):
    context.client = WebClient()

def before_scenario(context, scenario):
    if "data-1" in context.tags:
        pass

def after_all(context):
    context.client.stop()