module InstallmentPlansHelper
  extend ActionView::Helpers

  def categories_options(categories, selected_value = nil)
    options_for_select(categories.map { |category| [category.name, category.id] }, selected_value)
  end
end