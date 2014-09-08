require 'paratrooper'

namespace :deploy do
  desc 'Deploy app in staging environment'
  task :staging do
    deployment = Paratrooper::Deploy.new("mysterious-lowlands-6704-stage", tag: 'staging')

    deployment.deploy
  end

  desc 'Deploy app in production environment'
  task :production do
    deployment = Paratrooper::Deploy.new("mysterious-lowlands-6704") do |deploy|
      deploy.tag              = 'production',
      deploy.match_tag        = 'staging' # , uncomment comma for next line
      # deploy.maintenance_mode = !ENV['NO_MAINTENANCE']
    end

    deployment.deploy
  end
end