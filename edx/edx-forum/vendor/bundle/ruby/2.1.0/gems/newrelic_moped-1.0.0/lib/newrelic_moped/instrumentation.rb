require 'new_relic/agent/method_tracer'
require 'new_relic/agent/datastores'

DependencyDetection.defer do
  @name = :moped

  depends_on do
    defined?(::Moped) && !NewRelic::Control.instance['disable_moped']
  end

  executes do
    NewRelic::Agent.logger.info 'Installing Moped instrumentation'
  end

  executes do
    Moped::Node.class_eval do
      include NewRelic::Agent::Instrumentation::Moped
      alias_method :logging_without_newrelic_trace, :logging
      alias_method :logging, :logging_with_newrelic_trace
    end
  end
end

module NewRelic
  module Agent
    module Instrumentation
      module Moped
        def logging_with_newrelic_trace(operations, &blk)
          operation_name, collection = determine_operation_and_collection(operations.first)
          log_statement = operations.first.log_inspect.encode("UTF-8")

          operation = case operation_name
                   when 'INSERT', 'UPDATE', 'CREATE', 'FIND_AND_MODIFY'  then 'save'
                   when 'QUERY', 'COUNT', 'GET_MORE', 'AGGREGATE'        then 'find'
                   when 'DELETE'                                         then 'destroy'
                   else
                     nil
                   end

          command = Proc.new { logging_without_newrelic_trace(operations, &blk) }
          res = nil

          if operation
            callback = Proc.new do |result, metric, elapsed|
              NewRelic::Agent::Datastores.notice_statement(log_statement, elapsed)
            end

            NewRelic::Agent::Datastores.wrap('MongoDB', operation, collection, callback) do
              res = command.call
            end
          else
            res = command.call
          end

          res
        end

        def determine_operation_and_collection(operation)
          log_statement = operation.log_inspect.encode("UTF-8")
          collection = "Unknown"
          if operation.respond_to?(:collection)
            collection = operation.collection
          end
          operation_name = log_statement.split[0]
          if operation_name == 'COMMAND' && log_statement.include?(":mapreduce")
            operation_name = 'MAPREDUCE'
            collection = log_statement[/:mapreduce=>"([^"]+)/,1]
          elsif operation_name == 'COMMAND' && log_statement.include?(":count")
            operation_name = 'COUNT'
            collection = log_statement[/:count=>"([^"]+)/,1]
          elsif operation_name == 'COMMAND' && log_statement.include?(":aggregate")
            operation_name = 'AGGREGATE'
            collection = log_statement[/:aggregate=>"([^"]+)/,1]
          elsif operation_name == 'COMMAND' && log_statement.include?(":findAndModify")
            operation_name = 'FIND_AND_MODIFY'
            collection = log_statement[/:findAndModify=>"([^"]+)/,1]
          end
          return operation_name, collection
        end
      end
    end
  end
end