
def divide(char = '#')
  puts ""
  puts char * 72
  puts ""
end

def show(caption, object)
  puts caption
  puts ""
  
  if object.is_a?(String)
    puts object
  else
    pp object
  end

  puts ""
end

divide

require_relative 'apps/gmail/markup'

puts "GMAIL TESTS"

# Confirm Action (takes additional keyword options)
confirm_action = Apps::Gmail::Markup.confirm_action('Button Text', 'http://example.org/confirm/endpoint')

show 'confirm_action.as_json', confirm_action.as_json
# => {"@context"=>"http://schema.org", "@type"=>"EmailMessage", "potentialAction"=>{"@type"=>"ConfirmAction", "handler"=>{"@type"=>"HttpActionHandler", "url"=>"http://example.org/confirm/endpoint"}}}

show 'confirm_action.to_json', confirm_action.to_json
# => {"@context":"http://schema.org","@type":"EmailMessage","potentialAction":{"@type":"ConfirmAction","handler":{"@type":"HttpActionHandler","url":"http://example.org/confirm/endpoint"}}}

# NOTE: `to_script` is only available on "context" objects that represent the root of the markup
#       needed for embedding in emails. This is the object returned by each of the helper methods
#       above for each "Action"
show 'confirm_action.to_script', confirm_action.to_script
# =>
# <script type="application/ld+json">
# {
#   "@context": "http://schema.org",
#   "@type": "EmailMessage",
#   "potentialAction": {
#     "@type": "ConfirmAction",
#     "handler": {
#       "@type": "HttpActionHandler",
#       "url": "http://example.org/confirm/endpoint"
#     }
#   }
# }
# </script>

# Save Action (takes additional keyword options)
save_action = Apps::Gmail::Markup.save_action('Button Text', 'http://example.org/save/endpoint')

show 'save_action', save_action.to_script

# RSVP Action (takes additional keyword options)
rsvp_action = Apps::Gmail::Markup.rsvp_action('Event Name',
                yes_url:   'http://example.org/yes/endpoint',
                no_url:    'http://example.org/no/endpoint',
                maybe_url: 'http://example.org/maybe/endpoint'
              )

show 'rsvp_action', rsvp_action.to_script

# View Action (takes additional keyword options)
view_action = Apps::Gmail::Markup.view_action('Button Text', 'http://example.org/save/endpoint')

show 'view_action', view_action.to_script

# Track Action (takes additional keyword options)
track_action = Apps::Gmail::Markup.track_action('Button Text', 'http://example.org/save/endpoint')

show 'track_action', track_action.to_script

divide

require_relative 'apps/outlook/actionable_messages'

puts "OUTLOOK TESTS"

message_card = Apps::Outlook::ActionableMessages.message_card('Summary text', 'Title text')

section = message_card.add_section('Section title', start_group: true, activity_image: 'http://img')
section.add_fact('Username', 'joelvh')
section.actions << Apps::Outlook::Schema::OpenUri.new(name: 'Section open uri action').tap { |s| s.add_target('http://target/section')}

show "section.actions", section.actions

pp message_card.serialize

section2 = message_card.add_section('Section 2 title', start_group: false, activity_image: 'http://img2')
section2.add_image('http://gallery1')
section2.add_image('http://gallery2', title: 'Gallery 2 caption')

message_card.actions << Apps::Outlook::Schema::OpenUri.new(name: 'Card open uri action')

action_card = Apps::Outlook::Schema::ActionCard.new(name: 'Action card form')

action_card.inputs << Apps::Outlook::Schema::DateInput.new(id: 'due_date', title: 'Due Date', value: '2008-01-01')
action_card.inputs << Apps::Outlook::Schema::TextInput.new(id: 'username', title: 'Username', value: 'fakeuser')
action_card.inputs << Apps::Outlook::Schema::MultichoiceInput.new(id: 'rating', title: 'Rating', value: '3').tap do |multi|
  multi.add_choice('1 Star', '1')
  multi.add_choice('3 Star', '3')
  multi.add_choice('5 Star', '5')
end

section2.actions << action_card

show "message_card.actions", message_card.actions

pp message_card.serialize

divide('-')

puts message_card.to_script

divide
