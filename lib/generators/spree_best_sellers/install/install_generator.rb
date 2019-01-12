module SpreeBestSellers
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_best_sellers\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_best_sellers\n"
      end

      def add_stylesheets
        frontend_css_file = "vendor/assets/stylesheets/spree/frontend/all.css"
        backend_css_file = "vendor/assets/stylesheets/spree/backend/all.css"

        if File.exist?(backend_css_file) && File.exist?(frontend_css_file)
          inject_into_file frontend_css_file, " *= require spree/frontend/spree_best_sellers\n", :before => /\*\//, :verbose => true
          inject_into_file backend_css_file, " *= require spree/backend/spree_best_sellers\n", :before => /\*\//, :verbose => true
        end
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_best_sellers'
      end

      def run_migrations
         res = ask 'Would you like to run the migrations now? [Y/n]'
         if res == '' || res.downcase == 'y'
           run 'bundle exec rake db:migrate'
         else
           puts 'Skipping rake db:migrate, don\'t forget to run it!'
         end
      end
    end
  end
end
