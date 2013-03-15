require 'time'
require 'hipchat'
require 'active_support/time'
require 'asana_digest/client'
require 'asana_digest/task_list'
require 'asana_digest/template'

module AsanaDigest
  class Task
    attr_reader :asana, :hipchat

    def initialize(args)
      @asana = AsanaDigest::Client.new(ENV['ASANA_DIGEST_APIKEY'])
      @hipchat = HipChat::Client.new(ENV['ASANA_DIGEST_HIPCHAT_TOKEN'])[ENV['ASANA_DIGEST_HIPCHAT_ROOM_NAME'].to_i]
      @name = 'Asana Digest'
    end

    def active_users(users)
      if ENV['ASANA_DIGEST_ACTIVE_USERS']
        ENV['ASANA_DIGEST_ACTIVE_USERS'].split(',').map { |id|
          users.find {|data| data['id'] == id.to_i }
        }
      else
        users
      end
    end

    def previous_work_day
      # Use TZ=Asia/Tokyo to change the timezone
      # TODO: This doesn't take holidays into account
      today = Time.now
      today.monday? ? (today - 3.days) : (today - 1.day)
    end

    def date_includes?(date, completed)
      time = Time.parse(completed)
      time.between?(date.beginning_of_day, date.end_of_day)
    end

    def render_tasks(template, user, tasks, date=nil)
      result = AsanaDigest::Template.render(template, binding)
      color = tasks.empty? ? "yellow" : "green"
      hipchat.send(@name, result, :color => color, :message_format => 'html')
    end

    def run
      date = previous_work_day

      tasks = []
      ENV['ASANA_DIGEST_PROJECT_ID'].split(',').each do |project|
        tasks += asana.get("/projects/#{project}/tasks?opt_fields=assignee,completed_at,name")
      end

      done = TaskList.new
      will_do = TaskList.new

      tasks.each do |task|
        next if task['assignee'].nil?

        if task['completed_at'].nil?
          will_do.add task['assignee']['id'], task
        elsif date_includes?(date, task['completed_at'])
          done.add task['assignee']['id'], task
        end
      end

      users = active_users(asana.get("/users"))

      users.each do |user|
        render_tasks(:done, user, done.tasks_for(user['id']), date)
      end

      users.each do |user|
        render_tasks(:will_do, user, will_do.tasks_for(user['id']))
      end
    end
  end
end

