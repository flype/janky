module Janky
  module Notifier
    class ChatService
      def self.completed(build)
        status = build.green? ? "was successful" : "failed"
        color = build.green? ? "green" : "red"

        message = "Build #%s (%s) of %s/%s %s (%ss) %s - %s" % [
          build.number,
          build.short_sha1,
          build.repo_name,
          build.branch_name,
          status,
          build.duration,
          "#{base_url}#{build.number}/output",
          build.compare
        ]

        ::Janky::ChatService.speak(message, build.room_id, {:color => color})
      end

      def self.base_url
        @settings['JANKY_BASE_URL']
      end
    end
  end
end
