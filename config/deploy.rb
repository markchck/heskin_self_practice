
## config/deploy.rb

# #FIXME add your app name here
lock "~> 3.16.0"

## [변수 설정] 배포 프로젝트 이름
set :application, "heskin_self_practice"
# [Example] set :application, "test4674"

## [변수 설정] Rails 프로젝트가 저장된 Github
set :repo_url, "git@github.com:markchck/heskin_self_practice.git"
# [Example] git@github.com:kbs4674/cicd_test2.git

## Github(:repo_url)부터 프로젝트를 가져올 branch
set :branch, :master

## 배포 환경변수 설정
set :use_sudo, false
set :deploy_via, :remote_cache

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

## Github에 Push되면 안되는 중요한 파일에 있어선 해당 리스트에 추가하는게 좋음.
# 해당 리스트에 추가된 파일은 하단에 보이는 namespace :linked_files 부분에도 추가해줘야 합니다.
set :linked_files, %w{config/application.yml config/database.yml config/master.key}

## 프로젝트 배포 후 유지에 있어 공통으로 쓰이는 폴더들
# Capistrano에 배포된 프로젝트는 현재 상용서비스로 사용되는 프로젝트와 과거에 배포되었던 프로젝트 총 :keep_releases개 로 나뉘어 관리가 이루어진다.
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads public/img}

# Capistrano를 통해 배포된 현재/과거에 배포됐던 프로젝트 최대 수용갯수 (Default : 5)
set :keep_releases, 5

## [Rails Version 6.0 ~] linked_files 파일을 EC2 서버로 Upload
namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/application.yml ]")
          upload! 'config/application.yml', "#{shared_path}/config/application.yml"
        end
        
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
        
        unless test("[ -f #{shared_path}/config/database.yml ]")
          upload! 'config/database.yml', "#{shared_path}/config/database.yml"
        end
      end
    end
  end
end





# lock "~> 3.16.0"

# require 'capistrano-db-tasks'

# #FIXME add your app name here
# set :application, 'heskin_self_practice'
# #FIXME replace 'git@github.com:YOUR-GIT-REPO-HERE' with your git clone url
# set :repo_url, "git@github.com:markchck/heskin_self_practice.git"
# #FIXME add location on the server here
# set :deploy_to, '/home/deploy'
# set :branch, :master

# set :linked_files, %w{config/database.yml config/master.key}
# set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :keep_releases, 3
# set :keep_assets, 3

# set :db_local_clean, true
# set :db_remote_clean, true

# namespace :deploy do
#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end

#   after :publishing, 'deploy:restart'
#   after :finishing, 'deploy:cleanup'
# end
