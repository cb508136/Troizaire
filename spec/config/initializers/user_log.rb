require 'user_log/user_log'

class ActionController::Base
	extend UserLog::ClassMethods
end
