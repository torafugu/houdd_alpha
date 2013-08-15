require 'spec_helper'

describe MiniMapRoad do
  context 'is_constructing?' do
    context 'true' do
      mini_map_road_active1 = FactoryGirl.create(:mini_map_road_active1)
      production_que = FactoryGirl.build(:production_que_for_mini_map_road_create)
      production_que.que_id = mini_map_road_active1.id
      production_que.save

      it do
        expect(mini_map_road_active1.is_constructing?).to be_true
      end
    end

    context 'false' do
      mini_map_road_active2 = FactoryGirl.create(:mini_map_road_active1)
      it do
        expect(mini_map_road_active2.is_constructing?).to be_false
      end
    end
  end

  context 'is_destroying?' do
    context 'true' do
      mini_map_road_active1 = FactoryGirl.create(:mini_map_road_active1)
      production_que = FactoryGirl.build(:production_que_for_mini_map_road_destroy)
      production_que.que_id = mini_map_road_active1.id
      production_que.save

      it do
        expect(mini_map_road_active1.is_destroying?).to be_true
      end
    end

    context 'false' do
      mini_map_road_active2 = FactoryGirl.create(:mini_map_road_active1)
      it do
        expect(mini_map_road_active2.is_destroying?).to be_false
      end
    end
  end

  context 'status_txt' do
    context 'not active' do
      mini_map_road = FactoryGirl.create(:mini_map_road)
      it do
        expect(mini_map_road.status_txt).to eq(I18n.t('activerecord.attributes.mini_map_road.disable'))
      end
    end

    context 'active' do
      mini_map_road_active1 = FactoryGirl.create(:mini_map_road_active1)
      it do
        expect(mini_map_road_active1.status_txt).to eq(I18n.t('activerecord.attributes.mini_map_road.active'))
      end
    end

    context 'constructing' do
      mini_map_road_active2 = FactoryGirl.create(:mini_map_road_active2)
      production_que = FactoryGirl.build(:production_que_for_mini_map_road_create)
      production_que.que_id = mini_map_road_active2.id
      production_que.save
      it do
        expect(mini_map_road_active2.status_txt).to eq(I18n.t('activerecord.attributes.mini_map_road.construct'))
      end
    end

    context 'destroying' do
      mini_map_road_active2 = FactoryGirl.create(:mini_map_road_active2)
      production_que = FactoryGirl.build(:production_que_for_mini_map_road_destroy)
      production_que.que_id = mini_map_road_active2.id
      production_que.save
      it do
        expect(mini_map_road_active2.status_txt).to eq(I18n.t('activerecord.attributes.mini_map_road.destroy'))
      end
    end
  end
end
