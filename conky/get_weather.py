import requests as rq
from sys import exit
from time import sleep
import re

sleep(2)

try:
	req = rq.get('https://p.ya.ru/krasnoyarsk', timeout=3)
except rq.exceptions.ConnectionError:
	print("- ℃", end='')
	exit()

if (req.status_code != 200):
	print("- ℃", end='')
	exit()

html = req.text
temper = re.findall('{\"temp\":([-+]*[\d]+)}', html)
print("{} ℃".format(temper[0]), end='')
