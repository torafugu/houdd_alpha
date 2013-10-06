require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ItemSpResourceInvsController do

  # This should return the minimal set of attributes required to create a valid
  # ItemSpResourceInv. As you add validations to ItemSpResourceInv, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "item_info" => "" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ItemSpResourceInvsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all item_sp_resource_invs as @item_sp_resource_invs" do
      item_sp_resource_inv = ItemSpResourceInv.create! valid_attributes
      get :index, {}, valid_session
      assigns(:item_sp_resource_invs).should eq([item_sp_resource_inv])
    end
  end

  describe "GET show" do
    it "assigns the requested item_sp_resource_inv as @item_sp_resource_inv" do
      item_sp_resource_inv = ItemSpResourceInv.create! valid_attributes
      get :show, {:id => item_sp_resource_inv.to_param}, valid_session
      assigns(:item_sp_resource_inv).should eq(item_sp_resource_inv)
    end
  end

  describe "GET new" do
    it "assigns a new item_sp_resource_inv as @item_sp_resource_inv" do
      get :new, {}, valid_session
      assigns(:item_sp_resource_inv).should be_a_new(ItemSpResourceInv)
    end
  end

  describe "GET edit" do
    it "assigns the requested item_sp_resource_inv as @item_sp_resource_inv" do
      item_sp_resource_inv = ItemSpResourceInv.create! valid_attributes
      get :edit, {:id => item_sp_resource_inv.to_param}, valid_session
      assigns(:item_sp_resource_inv).should eq(item_sp_resource_inv)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ItemSpResourceInv" do
        expect {
          post :create, {:item_sp_resource_inv => valid_attributes}, valid_session
        }.to change(ItemSpResourceInv, :count).by(1)
      end

      it "assigns a newly created item_sp_resource_inv as @item_sp_resource_inv" do
        post :create, {:item_sp_resource_inv => valid_attributes}, valid_session
        assigns(:item_sp_resource_inv).should be_a(ItemSpResourceInv)
        assigns(:item_sp_resource_inv).should be_persisted
      end

      it "redirects to the created item_sp_resource_inv" do
        post :create, {:item_sp_resource_inv => valid_attributes}, valid_session
        response.should redirect_to(ItemSpResourceInv.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item_sp_resource_inv as @item_sp_resource_inv" do
        # Trigger the behavior that occurs when invalid params are submitted
        ItemSpResourceInv.any_instance.stub(:save).and_return(false)
        post :create, {:item_sp_resource_inv => { "item_info" => "invalid value" }}, valid_session
        assigns(:item_sp_resource_inv).should be_a_new(ItemSpResourceInv)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ItemSpResourceInv.any_instance.stub(:save).and_return(false)
        post :create, {:item_sp_resource_inv => { "item_info" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested item_sp_resource_inv" do
        item_sp_resource_inv = ItemSpResourceInv.create! valid_attributes
        # Assuming there are no other item_sp_resource_invs in the database, this
        # specifies that the ItemSpResourceInv created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ItemSpResourceInv.any_instance.should_receive(:update_attributes).with({ "item_info" => "" })
        put :update, {:id => item_sp_resource_inv.to_param, :item_sp_resource_inv => { "item_info" => "" }}, valid_session
      end

      it "assigns the requested item_sp_resource_inv as @item_sp_resource_inv" do
        item_sp_resource_inv = ItemSpResourceInv.create! valid_attributes
        put :update, {:id => item_sp_resource_inv.to_param, :item_sp_resource_inv => valid_attributes}, valid_session
        assigns(:item_sp_resource_inv).should eq(item_sp_resource_inv)
      end

      it "redirects to the item_sp_resource_inv" do
        item_sp_resource_inv = ItemSpResourceInv.create! valid_attributes
        put :update, {:id => item_sp_resource_inv.to_param, :item_sp_resource_inv => valid_attributes}, valid_session
        response.should redirect_to(item_sp_resource_inv)
      end
    end

    describe "with invalid params" do
      it "assigns the item_sp_resource_inv as @item_sp_resource_inv" do
        item_sp_resource_inv = ItemSpResourceInv.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ItemSpResourceInv.any_instance.stub(:save).and_return(false)
        put :update, {:id => item_sp_resource_inv.to_param, :item_sp_resource_inv => { "item_info" => "invalid value" }}, valid_session
        assigns(:item_sp_resource_inv).should eq(item_sp_resource_inv)
      end

      it "re-renders the 'edit' template" do
        item_sp_resource_inv = ItemSpResourceInv.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ItemSpResourceInv.any_instance.stub(:save).and_return(false)
        put :update, {:id => item_sp_resource_inv.to_param, :item_sp_resource_inv => { "item_info" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested item_sp_resource_inv" do
      item_sp_resource_inv = ItemSpResourceInv.create! valid_attributes
      expect {
        delete :destroy, {:id => item_sp_resource_inv.to_param}, valid_session
      }.to change(ItemSpResourceInv, :count).by(-1)
    end

    it "redirects to the item_sp_resource_invs list" do
      item_sp_resource_inv = ItemSpResourceInv.create! valid_attributes
      delete :destroy, {:id => item_sp_resource_inv.to_param}, valid_session
      response.should redirect_to(item_sp_resource_invs_url)
    end
  end

end