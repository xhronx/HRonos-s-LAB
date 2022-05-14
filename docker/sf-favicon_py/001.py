import requests
import favicon

icons = favicon.get('https://skillfactory.ru/')
icon = icons[0]

response = requests.get(icon.url, stream=True)
with open('/tmp/skillfactory-favicon.{}'.format(icon.format), 'wb') as image:
    for chunk in response.iter_content(1024):
        image.write(chunk)