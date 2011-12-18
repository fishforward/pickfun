## 应用全局变量 - 开发环境
#图片服务器路径前缀
PRE_PATH = "dev/"
# 图片地址前缀
FILE_PATH_PRE ='http://forward.b0.upaiyun.com/'+PRE_PATH
MIDDLE_PIC = '!middle'
BIG_PIC = '!big'


# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

