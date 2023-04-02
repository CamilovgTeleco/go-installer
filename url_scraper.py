import requests
import lxml.html as html

def run():
    try:
        response = requests.get("https://go.dev/dl/")
        if response.status_code != 200:
            raise Exception
        else:
            home = response.content.decode("utf-8")
            parsed = html.fromstring(home)
            index_link = parsed.xpath('//a[@class="download downloadBox"]/div[1]/text()')
            index_link = index_link.index("Linux")
            link_installer = 'https://go.dev/'+parsed.xpath(f'//a[@class="download downloadBox"]/@href')[index_link]
            print(link_installer)
    except Exception as err:
        print(err)

if __name__ == "__main__":
    run()