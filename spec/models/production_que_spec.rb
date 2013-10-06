require 'spec_helper'

describe ProductionQue do
  context 'item_txt' do
    context 'mini_map_road' do
      it do
        mini_map_hq = FactoryGirl.create(:mini_map_hq)
        mini_map_road = FactoryGirl.create(:mini_map_road)
        production_que = FactoryGirl.build(:production_que_for_mini_map_road_create)
        production_que.que_id = mini_map_road.id
        production_que.save

        mini_map_road_txt = I18n.t('activerecord.attributes.production_que.mini_map_road')
        mini_map_road_txt += "(" + mini_map_road.start_mini_map.name + "..." + mini_map_road.end_mini_map.name + ")"

        expect(production_que.item_txt).to eq(mini_map_road_txt)
      end
    end

    context 'mini_map_cell' do
      it do
        mini_map_cell = FactoryGirl.create(:mini_map_cell_constrcution_1)
        production_que = FactoryGirl.build(:production_que_for_construction_create)
        production_que.que_id = mini_map_cell.save
        production_que.save

        mini_map_cell_txt = "(" + mini_map_cell.mini_map.name + ":" + mini_map_cell.x.to_s + "," + mini_map_cell.y.to_s + ")"

        expect(production_que.item_txt).to eq(mini_map_cell.construction.name + mini_map_cell_txt)
      end
    end
  end

  context 'status_txt' do
    context 'destroy' do
      it do
        production_que = FactoryGirl.create(:production_que_for_mini_map_road_destroy)
        expect(production_que.status_txt).to eq(I18n.t('activerecord.attributes.production_que.destroy'))
      end
    end

    context 'construct' do
      it do
        production_que = FactoryGirl.create(:production_que_for_mini_map_road_create)
        expect(production_que.status_txt).to eq(I18n.t('activerecord.attributes.production_que.construct'))
      end
    end
  end

  context 'destroy_que_item' do
    context 'mini_map_road' do
      it do
        mini_map_road = FactoryGirl.create(:mini_map_road)
        production_que = FactoryGirl.build(:production_que_for_mini_map_road_create)
        production_que.que_id = mini_map_road.id
        production_que.save

        production_que.destroy_que_item

        expect(production_que.que_item).to be_nil
      end
    end
    context 'mini_map_cell' do
      it do
        mini_map_cell = FactoryGirl.create(:mini_map_cell_constrcution_1)
        production_que = FactoryGirl.build(:production_que_for_construction_create)
        production_que.que_id = mini_map_cell.id
        production_que.save

        production_que.destroy_que_item

        expect(production_que.que_item.construction_id).to be_nil
      end
    end
    context 'item' do
      it do
        item = FactoryGirl.create(:item)
        production_que = FactoryGirl.build(:production_que_for_item_create)
        production_que.que_id = item.id
        production_que.save

        production_que.destroy_que_item

        expect(production_que.que_item).to be_nil
      end
    end
  end
end
