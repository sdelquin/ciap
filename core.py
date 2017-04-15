import json
from collections import OrderedDict

VAT_FACTOR = 0.82644865925
TAX_THRESHOLD = 22
CARRIERS = (
    "DHL",
    "CORREOS",
    "UPS",
)
LOW_TAX = {
    "DHL": 6.30,
    "CORREOS": 6.60,
    "UPS": 22.50,
}
HIGH_TAX = {
    "DHL": 12.25,
    "CORREOS": 13.74,
    "UPS": 22.50,
}
IGIC = 0.07
MAIN_CARRIER = "CORREOS"


class AmazonPrice():

    def __init__(self, raw_price):
        try:
            self.raw_price = raw_price
            self.vat_excluded_price = self.raw_price * VAT_FACTOR
            self.price_of_customs = {}
            self.price_plus_customs = {}
            if (self.vat_excluded_price < TAX_THRESHOLD):
                for sender in CARRIERS:
                    self.price_of_customs[sender] = LOW_TAX[sender]
                    self.price_plus_customs[sender] = self.vat_excluded_price \
                        + self.price_of_customs[sender]
            else:
                for sender in CARRIERS:
                    self.price_of_customs[sender] = HIGH_TAX[sender] \
                        + IGIC * self.vat_excluded_price
                    self.price_plus_customs[sender] = self.vat_excluded_price \
                        + self.price_of_customs[sender]

            self.price_plus_customs = OrderedDict(
                sorted(self.price_plus_customs.items(),
                       key=lambda t: t[1]))
        except Exception as e:
            raise e

    def is_main_carrier(self, carrier):
        if (carrier == MAIN_CARRIER):
            return True
        else:
            return False

    def to_JSON(self):
        return json.dumps(self, default=lambda o: o.__dict__)
