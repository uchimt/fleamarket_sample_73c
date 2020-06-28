# config valid only for current version of Capistrano
# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.14.0'

# Capistranoのログの表示に利用する
set :application, 'fleamarket_sample_73c'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:uchimt/fleamarket_sample_73c.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :linked_files, fetch(:linked_files, []).push("config/master.key")

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' 

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/deploy.pem'] 

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5
#credentials.yml.encではmasterkeyにする
set :linked_files, %w{config/master.key}
# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

desc 'upload master.key'
task :upload do
  on roles(:app) do |host|
    if test "[ ! -d #{shared_path}/config ]"
      execute "mkdir -p #{shared_path}/config"
    end
    upload!('config/master.key', "#{shared_path}/config/master.key")
  end
end
before :starting, 'deploy:upload'
after :finishing, 'deploy:cleanup'
end

#環境変数をcapistaranoでの自動デプロイで使用
set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
  AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
  AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"]
}

#本番環境でのみBasic認証をするための記述
server "54.168.66.180", user: "ec2-user", roles:%w{app db web}

set :rails_env, "production"
set :unicorn_rack_env, "production"