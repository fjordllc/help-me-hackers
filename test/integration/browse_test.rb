require 'test_helper'

class BrowseTest < ActionController::IntegrationTest
  fixtures :all

  should_respond_with_path :success, '/'
  should_respond_with_path :success, '/index.html'
  should_respond_with_path 302, '/logout'
  should_respond_with_path 302, '/oauth_callback'
  should_respond_with_path :success, '/problems/category/plugin-making'
  should_respond_with_path :success, '/problems/tag/wordpress'
  should_respond_with_path :success, '/users/language/php'
  should_respond_with_path :success, '/users/hacker'
  should_respond_with_path :success, '/users/hackee'
  should_respond_with_path 302, '/hacks/1/edit'
  should_respond_with_path :success, '/hacks/1'
  should_respond_with_path :success, '/problems'
  should_respond_with_path :success, '/problems/wanted'
  should_respond_with_path :success, '/problems/unsolved'
  should_respond_with_path 302, '/problems/new'
  should_respond_with_path 302, '/problems/1/edit'
  should_respond_with_path 302, '/dashboard'
  should_respond_with_path 302, '/account/edit'
  should_respond_with_path :success, '/about'
  should_respond_with_path :success, '/about/category'
  should_respond_with_path :success, '/about/license'
  should_respond_with_path :success, '/about/markdown'
  should_respond_with_path :success, '/about/terms'
  should_respond_with_path :success, '/about/hint'
  should_respond_with_path :success, '/users'
  should_respond_with_path :success, '/komagata_fjord'
  should_respond_with_path :success, '/machida_fjord'
  should_respond_with_path :success, '/michael_fjord'
  should_respond_with_path 404, '/unknownusername'
end
