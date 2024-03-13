class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.inherited(subclass)
    super
    subclass.instance_eval do
      def not_multitenant!
        @multitenant = false
      end

      def supports_multitenancy?
        @multitenant.nil? || @multitenant
      end
    end

    trace = TracePoint.new(:end) do |tp|
      if tp.self == subclass
        trace.disable
        if subclass.supports_multitenancy?
          subclass.instance_eval do
            default_scope { where(company_id: Company.current_company_id) }
          end
        end
      end
    end
    trace.enable 
  end
end
