if defined?(ActiveRecord) &&  defined?(ActiveRecord::ConnectionAdapters)
  ActiveRecord::ConnectionAdapters::AbstractAdapter.class_eval do
    def log_with_rack_bug(*args, &block)
      Rack::Bug::SQLPanel.record(args.first, Kernel.caller) do
        log_without_rack_bug(*args, &block)
      end
    end

    alias_method_chain :log, :rack_bug
  end
end
