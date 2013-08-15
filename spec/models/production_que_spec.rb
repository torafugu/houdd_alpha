require 'spec_helper'

describe ProductionQue do
  context 'item_txt' do
    context 'mini_map_road' do
      production_que = FactoryGirl.create(:production_que_for_mini_map_road_create)

      it do
        expect(production_que.item_txt).to eq(I18n.t('activerecord.attributes.production_que.mini_map_road'))
      end
    end

    context 'mini_map_cell' do
      mini_map_cell = FactoryGirl.create(:mini_map_cell_constrcution_1)
      production_que = FactoryGirl.build(:production_que_for_construction_create)
      production_que.que_id = mini_map_cell.save
      production_que.save

      mini_map_cell_txt = "(" + mini_map_cell.mini_map.name + 
        ":" + mini_map_cell.x.to_s + "," + mini_map_cell.y.to_s + ")"

      it do
        expect(production_que.item_txt).to eq(mini_map_cell.construction.name + mini_map_cell_txt)
      end
    end
  end

  context 'status_txt' do
    context 'destroy' do
      production_que = FactoryGirl.create(:production_que_for_mini_map_road_destroy)

      it do
        expect(production_que.status_txt).to eq(I18n.t('activerecord.attributes.production_que.destroy'))
      end
    end

    context 'construct' do
      production_que = FactoryGirl.create(:production_que_for_mini_map_road_create)

      it do
        expect(production_que.status_txt).to eq(I18n.t('activerecord.attributes.production_que.construct'))
      end
    end
  end
end
