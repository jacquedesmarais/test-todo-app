require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should return true if all tasks are completed' do
      list = List.create(name: "chores")
      task1 = Task.create(list_id: list.id, complete: false)
      task2 = Task.create(list_id: list.id, complete: false)

      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should add 1 hour to all tasks' do
      now_time_object = Time.now
      list = List.create(name: "chores")
      task1 = Task.create(list_id: list.id, deadline: now_time_object)
      task2 = Task.create(list_id: list.id, deadline: now_time_object)

      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(now_time_object + 1.hour)
      end
    end 
  end

  describe '#total_duration' do
    it 'should add up all hours of tasks' do
      list = List.create(name: "chores")
      task1 = Task.create(list_id: list.id, duration: 60)
      task2 = Task.create(list_id: list.id, duration: 10)

      expect(list.total_duration).to eq(70)
    end
  end

  describe '#incomplete_tasks' do
    it 'should list all tasks that are incomplete' do
      list = List.create(name: "chores")
      Task.create(list_id: list.id, complete: false)
      Task.create(list_id: list.id, complete: true)
      Task.create(list_id: list.id, complete: true)
      Task.create(list_id: list.id, complete: false)

      expect(list.incomplete_tasks.count).to eq(2)
    end
  end

  describe '#favorite_tasks' do
    it 'should only return tasks with a favorite of true' do
     list = List.create(name: "chores")
     task1 = Task.create(list_id: list.id, favorite: false)
     task2 = Task.create(list_id: list.id, favorite: true)
     task3 = Task.create(list_id: list.id, favorite: true)

     expect(list.favorite_tasks.count).to eq(2)
    end
  end
end