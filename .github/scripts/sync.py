import requests
import os
import base64

NOTION_API_TOKEN = os.getenv('NOTION_API_TOKEN')
GITHUB_API_TOKEN = os.getenv('GITHUB_API_TOKEN')
NOTION_PAGE_ID = os.getenv('NOTION_PAGE_ID')
REPO_OWNER = os.getenv('REPO_OWNER')
REPO_NAME = os.getenv('REPO_NAME')
REPO_README_PATH = os.getenv('REPO_README_PATH') 

# Notion API 호출을 위한 헤더 설정
notion_headers = {
    'Authorization': f'Bearer {NOTION_API_TOKEN}',
    'Content-Type': 'application/json',
    'Notion-Version': '2022-06-28',  # 최신 Notion API 버전 (23/12/2 기준)
}

# Notion 페이지의 내용을 가져오는 함수
def get_notion_content():
    notion_url = f'https://api.notion.com/v1/blocks/{NOTION_PAGE_ID}/children?page_size=100'
    response = requests.get(notion_url, headers=notion_headers)
    data = response.json()
    return data['results'][0]['paragraph']['rich_text']['text']['content']

# GitHub API 호출을 위한 헤더 설정
github_headers = {
    'Authorization': f'Bearer {GITHUB_API_TOKEN}',
    'Content-Type': 'application/json',
}

# GitHub README를 업데이트하는 함수
def update_github_readme(content):
    github_url = f'https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/contents/{REPO_README_PATH}/README.md'
    
    # GitHub API를 사용하여 README 파일 정보 가져오기
    response = requests.get(github_url, headers=github_headers)
    response.raise_for_status()
    readme_info = response.json()

    # 가져온 README 정보에서 sha 값 추출
    current_sha = readme_info['sha']

    # GitHub README를 업데이트하는 함수
    body = {
        'message': '[Sync] Update README from Notion',
        'content': base64.b64encode(content.encode('UTF-8')).decode('UTF-8'),
        'sha': current_sha,  # 동적으로 가져온 sha 값 사용
    }

    # GitHub API를 사용하여 README 파일 업데이트
    response = requests.put(github_url, headers=github_headers, json=body)
    response.raise_for_status()
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
