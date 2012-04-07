# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Set the input focus for a specific id
  # Usage: <%= set_focus_to 'form_field_label' %>
  def set_focus_to(id)
    javascript_tag(" $(document).ready(function(){$('##{id}').focus()});");
  end
  
end
