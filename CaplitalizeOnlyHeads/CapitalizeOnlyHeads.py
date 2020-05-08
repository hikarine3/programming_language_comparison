class CapitalizeOnlyHeads:
    def __init__(self, opt = {}):
        pass

    def convert(self, str):
        return str.title()

if __name__ == "__main__":
    capitalizer = CapitalizeOnlyHeads()
    str = " can you caplitalize?"
    print(capitalizer.convert(str))
