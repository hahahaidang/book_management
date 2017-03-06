# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( *.js )
Rails.application.config.assets.precompile += %w( *.coffee )

#index
Rails.application.config.assets.precompile += %w( welcome/index.css )
Rails.application.config.assets.precompile += %w( welcome/search_result.css )


#login
Rails.application.config.assets.precompile += %w( login/login_page.css )
Rails.application.config.assets.precompile += %w( login/login_success.css )
Rails.application.config.assets.precompile += %w( login/login_fail.css )
Rails.application.config.assets.precompile += %w( login/logout_page.css )


#suggestion
Rails.application.config.assets.precompile += %w( suggest/suggest_page.css )

#management
Rails.application.config.assets.precompile += %w( manage_book/managebook_page.css )
Rails.application.config.assets.precompile += %w( manage_book/approve_page.css )
Rails.application.config.assets.precompile += %w( manage_book/detail_page.css )
Rails.application.config.assets.precompile += %w( manage_book/management_detail_page.css )

#suggest_list
Rails.application.config.assets.precompile += %w( suggest_list/suggest_list_page.css )
Rails.application.config.assets.precompile += %w( suggest_list/detail_suggest_list_page.css )







