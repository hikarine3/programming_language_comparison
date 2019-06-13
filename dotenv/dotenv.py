import os
from firstclass_dotenv import Dotenv

if __name__ == "__main__":
  dotenv = Dotenv()
  dotenv.load()
  print(os.environ["ENVVALUE"])

