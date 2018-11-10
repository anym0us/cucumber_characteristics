# http://stackoverflow.com/questions/4470108/when-monkey-patching-a-method-can-you-call-the-overridden-method-from-the-new-i

module Cucumber
  class StepMatch
    if method_defined?(:invoke)
      old_invoke = instance_method(:invoke)
      attr_reader :duration

      define_method(:invoke) do |multiline_arg|
        start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        ret = old_invoke.bind(self).call(multiline_arg)
        @duration = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time
        ret
      end
    end
  end
end

module Cucumber
  module Ast
    class StepInvocation
      attr_reader :step_match
    end
  end
end
