from datetime import datetime, timedelta

def get_xdays_ago(days_ago):
    x_days_ago = datetime.now() - timedelta(days=days_ago)
    return x_days_ago

print( get_xdays_ago(2).strftime("%Y/%m/%d") )

