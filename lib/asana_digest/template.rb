require 'erb'

module AsanaDigest
  class Template
    def self.done
      <<EOF
<% if tasks.empty? %>
On <%= date.strftime "%m/%d" %>, <b><%= user['name'] %></b> has not completed any tasks. :(
<% else %>
On <%= date.strftime "%m/%d" %>, <b><%= user['name'] %></b> has completed following tasks. <br/>
<% tasks.each do |task| %>
&#x2713; <%= task['name'] %> (<a href="https://app.asana.com/0/<%= ENV['ASANA_DIGEST_PROJECT_ID'] %>/<%= task['id'] %>">#<%= task['id'] %></a>)<br/>
<% end %>
<% end %>
EOF
    end

    def self.will_do
      <<EOF
<% if tasks.empty? %>
Today, <b><%= user['name'] %></b> hasn't scheduled any tasks to work on :(
<% else %>
Today, <b><%= user['name'] %></b> will work on following tasks.<br/>
<% tasks.each do |task| %>
&#x25a2; <%= task['name'] %> (<a href="https://app.asana.com/0/<%= ENV['ASANA_DIGEST_PROJECT_ID'] %>/<%= task['id'] %>">#<%= task['id'] %></a>)<br/>
<% end %>
<% end %>
EOF
    end

    def self.render(template, binding)
      ERB.new(send(template), nil, '<>').result(binding)
    end
  end
end

