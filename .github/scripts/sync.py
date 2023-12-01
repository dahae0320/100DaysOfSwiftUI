import requests
import os

NOTION_API_TOKEN = os.getenv('API_TOKEN_NOTION')
GITHUB_API_TOKEN = os.getenv('API_TOKEN_GITHUB')
NOTION_PAGE_ID = 'YOUR_NOTION_PAGE_ID'  # Notion 페이지의 ID를 입력하세요
REPO_OWNER = 'YOUR_GITHUB_REPO_OWNER'  # GitHub 레포지토리의 소유자를 입력하세요
REPO_NAME = 'YOUR_GITHUB_REPO_NAME'  # GitHub 레포지토리의 이름을 입력하세요

# Notion API 호출을 위한 헤더 설정
notion_headers = {
    'Authorization': f'Bearer {NOTION_API_TOKEN}',
    'Content-Type': 'application/json',
    'Notion-Version': '2023-08-01',  # 현재 Notion API 버전
}

# Notion 페이지의 내용을 가져오는 함수
def get_notion_content():
    notion_url = f'https://api.notion.com/v1/pages/{NOTION_PAGE_ID}'
    response = requests.get(notion_url, headers=notion_headers)
    data = response.json()
    return data['properties']['title']['title'][0]['text']['content']  # 예제에서는 제목만 가져옴

# GitHub API 호출을 위한 헤더 설정
github_headers = {
    'Authorization': f'Bearer {GITHUB_API_TOKEN}',
    'Content-Type': 'application/json',
}

# GitHub README를 업데이트하는 함수
def update_github_readme(content):
    github_url = f'https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/readme'
    readme_content = {
        'message': 'Update README from Notion',
        'content': content,
        'sha': 'YOUR_CURRENT_README_SHA',  # 현재 README의 SHA 값을 입력하세요
    }
    response = requests.put(github_url, headers=github_headers, json=readme_content)
    return response.status_code

if __name__ == '__main__':
    # Notion에서 데이터 가져오기
    notion_content = get_notion_content()

    # GitHub README 업데이트
    update_status = update_github_readme(notion_content)

    if update_status == 200:
        print('GitHub README 업데이트 성공!')
    else:
        print(f'GitHub README 업데이트 실패. 상태 코드: {update_status}')
