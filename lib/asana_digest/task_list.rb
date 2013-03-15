module AsanaDigest
  class TaskList
    def initialize
      @tasks = {}
    end

    def add(user, task)
      @tasks[user] ||= []
      @tasks[user] << task
    end

    def tasks_for(user)
      @tasks[user] || []
    end
  end
end
