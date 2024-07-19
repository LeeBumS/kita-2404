import os

# 현재 파일의 절대 경로를 기반으로 basedir 변수를 설정, 이 변수는 프로젝트의 기본 디렉터리를 나타낸다.
# os.path.abspath(path) : 주어진 경로 path의 절대 경로를 변환
# __file__의 디렉토리 부분만을 추출. D:\이범석 Kita-240424\WorkSpace\m4_웹애플리케이션\ TodoList_10
basedir = os.path.abspath




SECRET_KEY = '3c595d2d111d7fee7d7044f662279a24664f0629be3b6d3e'
SQLALCHEMY_DATABASE_URI = 'mysql://bum:bum@localhost:3307/bum_db'
SQLALCHEMY_TRACK_MODIFICATIONS = False
