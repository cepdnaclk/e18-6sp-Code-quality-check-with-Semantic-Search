import requests

# order = 'desc'  # for highest starred
order = 'asc'  # for lowest starred


def search_repositories(query, page=1, per_page=100):
    url = 'https://api.github.com/search/repositories'
    params = {
        'q': query,
        'sort': 'stars',
        'order': order,
        'page': page,
        'per_page': per_page
    }

    response = requests.get(url, params=params)
    response.raise_for_status()

    return response.json()['items']


def write_repository_links_to_file(links):
    if order == 'desc':
        outFileName = 'temp/highest_starred.txt'
    else:
        outFileName = 'temp/lowest_starred.txt'
    with open(outFileName, 'w') as file:
        for link in links:
            file.write(link + '\n')


def get_repository_links():
    query = 'stars:>0 language:python'
    total_repositories = 100
    repositories_per_page = 100
    num_pages = total_repositories // repositories_per_page

    repository_links = []

    for page in range(1, num_pages + 1):
        repositories = search_repositories(query, page=page)
        repository_links.extend([repo['html_url'] for repo in repositories])
        write_repository_links_to_file(repository_links)

    return repository_links


if __name__ == '__main__':
    links = get_repository_links()
    # write_repository_links_to_file(links)
    if order == 'desc':
        outFileName = 'highest_starred.txt'
    else:
        outFileName = 'lowest_starred.txt'
    print(f"Repository links have been written to '{outFileName}' file.")
