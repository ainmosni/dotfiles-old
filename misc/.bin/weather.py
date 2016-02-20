#!/usr/bin/env python

import requests

city = 'Berlin'

# Feel free to steal the key to a free service.
key = '264a2ad3038722f838a61315ad99e872'

def get_symbol(weather):
    daytime = False
    weather_id = weather['weather'][0]['id']
    if weather['sys']['sunrise'] < weather['dt'] < weather['sys']['sunset']:
        daytime = True

    if weather_id > 950:
        return '❓'

    if weather_id >= 900:
        return '⚠'

    if weather_id > 800:
        return '☁'

    if weather_id == 800:
        if daytime:
            return '☀'
        return '🌙 '

    if weather_id >= 700:
        return '🌁'

    if weather_id >= 600:
        return '❄'

    if weather_id >= 300:
        return '☔'

    return '⚡'


def main():
    weather = requests.get('http://api.openweathermap.org/data/2.5/weather',
                           params={'q': city,
                                   'APPID': key}).json()
    symbol = get_symbol(weather)
    print('{symbol} {temp}°'.format(
        symbol=symbol,
        temp=round(weather['main']['temp'] - 273.15)
    ))

if __name__ == '__main__':
    main()
