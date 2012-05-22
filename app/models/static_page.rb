# StaticPage model
#
# Important fields:
# * name <String>
# * content <Text>
class StaticPage < ActiveRecord::Base
  attr_accessible :content
end
