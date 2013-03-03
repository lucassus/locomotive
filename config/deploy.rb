require "bundler/capistrano"
load "deploy/assets"

server "192.168.33.10", :app, :web, :db, primary: true

set :application, "locomotive"
set :repository, "git@github.com:lucassus/#{application}.git"
# deploy from different branch: cap -S branch="<branchname>" deploy
set :branch, fetch(:branch, "master")
set :scm, "git"

ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :use_sudo, false
set :user, application
set :deploy_to, "/home/#{application}"
set :rails_env, "production"

set :keep_releases, 16

namespace :deploy do
  desc "Symlink shared/* files"
  task :symlink_shared, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
end

after "deploy:update_code", "deploy:symlink_shared"
after "deploy", "deploy:migrate"
after "deploy:restart", "deploy:cleanup"
