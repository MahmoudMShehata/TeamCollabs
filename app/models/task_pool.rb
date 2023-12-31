# frozen_string_literal: true

class TaskPool < ApplicationRecord
  belongs_to :team_leader, class_name: 'User'
  has_many :tasks, dependent: :destroy
  has_and_belongs_to_many :team_members, class_name: 'User', join_table: 'team_members'

  validates :team_leader, presence: true
  validates :name, presence: true

  def team
    User.joins(:tasks).where(tasks: { task_pool_id: id }).distinct
  end
end
