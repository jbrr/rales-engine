class MerchantSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :created_at,
             :updated_at

  def revenue
    { revenue: (object.to_f / 100).to_s } 
  end
end
