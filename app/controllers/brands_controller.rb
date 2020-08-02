def index 
  return nil if params[:keyword] = ""
  @brands = Brand.where('japanese_brand_name LIKE(?)', "%#{keyword}%").or(Brand.where('brand_name LIKE(?)', "%#{keyword}%"))

  respond_to do |format|
    format.html
    format.json
  end
end
