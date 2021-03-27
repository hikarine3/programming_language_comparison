from datetime import datetime, timedelta
class timeGetLocalToday:
    def __init__(self):
        pass

    def getToday(self):
        return datetime.now().strftime("%Y-%m-%d")

    def getYesterday(self):
        return (datetime.now() - timedelta(1)).strftime("%Y-%m-%d")

    def run(self):
        print("today=" + self.getToday())
        print("yesterday=" + self.getYesterday())

if __name__ == "__main__":
    tglt = timeGetLocalToday()
    tglt.run()
