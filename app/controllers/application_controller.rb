class ApplicationController < ActionController::Base
  include FlashesHelper
  include ApplicationHelper
  include Clearance::Controller
end
