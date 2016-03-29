module DecreaseLineItem
	extend ActiveSupport::Concern

	private	

  def decrease_line_item(line_item)
    @line_item = LineItem.find(line_item.id)
    @quantity = @line_item.quantity
    if @quantity <= 1
      @line_item.destroy
    else 
      @quantity -= 1
      @line_item.quantity = @quantity
      @line_item.save
    end
  end
end