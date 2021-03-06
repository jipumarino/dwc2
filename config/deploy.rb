set :application, "dwc2"
set :repository,  "git://github.com/jipumarino/dwc2.git"
set :deploy_to, "/var/apps/#{application}"
set :user, 'root'
set :use_sudo, false

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "pumarino.org"                          # Your HTTP server, Apache/etc
role :app, "pumarino.org"                          # This may be the same as your `Web` server
role :db,  "pumarino.org", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
