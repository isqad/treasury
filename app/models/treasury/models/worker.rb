# frozen_string_literal: true

module Treasury
  module Models
    class Worker < ActiveRecord::Base
      COMMON_NAME = 'common'
      ORDERS_NAME = 'orders'

      self.table_name = 'denormalization.workers'
      self.primary_key = 'id'

      has_many :fields, class_name: 'Treasury::Models::Field', inverse_of: :worker

      #validates :name, :presence => true, :length => {:maximum => 25}
      #validates_uniqueness_of :name

      scope :active, -> { where(:active => true) }

      def self.orders_worder
        where(name: ORDERS_NAME).first
      end

      def self.common_worker
        where(name: COMMON_NAME).first
      end

      def orders_worder?
        name == ORDERS_NAME
      end

      def common_worker?
        name == COMMON_NAME
      end

      def terminate
        update_attribute(:need_terminate, true)
      end

      def reset_terminate
        update_attribute(:need_terminate, false)
      end
    end
  end
end
