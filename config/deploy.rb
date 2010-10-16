set :application, "failurous"
set :repository,  "git@github.com:railsrumble/rr10-team-256.git"

set :scm, :git

server "li220-76.members.linode.com", :app, :web, :db, :primary => true
set :user, "www-data"
set :password, "y34ZjdlAPf7"
set :use_sudo, false
set :deploy_to, "/var/rails/#{application}"
set :rails_env, "production"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end


namespace :bundler do
  task :create_symlink, :roles => :app do
    bundled_gems_dir = File.join(shared_path, '.bundle')
    run("mkdir -p #{bundled_gems_dir} && cd #{release_dir} && ln -s #{bundled_gems_dir} .")
  end
  
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install" # --without test"
  end
  
  task :lock, :roles => :app do
    run "cd #{current_release} && bundle lock;"
  end
  
  task :unlock, :roles => :app do
    run "cd #{current_release} && bundle unlock;"
  end
end

after "deploy:update_code" do
  bundler.create_symlink
  bundler.bundle_new_release
end
