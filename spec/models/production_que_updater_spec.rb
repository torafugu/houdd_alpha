require 'spec_helper'

describe ProductionQueUpdater do
  context 'update' do
    it do
      item_info = FactoryGirl.create(:item_info)
      item = FactoryGirl.create(:item)
      production_que = FactoryGirl.build(:production_que_for_item_create)
      production_que.que_id = item.id
      production_que.save
      expect {
        ProductionQueUpdater.execute
      }.to change{production_que.que_item.built_point}.by(production_que.allotment)
    end
  end
  
  context 'delete' do
    it do
      item_info = FactoryGirl.create(:item_info)
      item = FactoryGirl.create(:item)
      production_que = FactoryGirl.build(:production_que_for_item_destroy)
      production_que.que_id = item.id
      production_que.save
      expect {
        ProductionQueUpdater.execute
      }.to change{ ProductionQue.find_by_id(production_que.id) }.to be_nil
    end
  end
end