## config/deploy/production.rb

## [변수 설정] Remote 서버 : 아이디
# AWS EC2 Ubuntu는 기본으로 아이디는 ubuntu 이다.
set :user, 'ubuntu'
## [Example] set :user, 'ubuntu'

## [변수 설정] REMOTE 서버 설정
set :remote_server_ip, "3.36.105.26"
# [Example] set :remote_server_ip, "52.78.236.246"

## [변수 설정] Remote서버에 대해 배포 환경변수 설정
set :rails_env, "production"
set :stage, :production

## Remote서버에서 프로젝트 배포가 이루어질 Path
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"

server fetch(:remote_server_ip), port: 22, roles: [:web, :app, :db], primary: true

## SSH Remote 설정 (서버 아이디 및 pem Key 경로 설정)
set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(/Users/jaeminki/OneDrive/programming/aws_key/chuckmark_pem_key.pem) }
# set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(C:\Users\KCM\Desktop\ruby-kcm.pem) }