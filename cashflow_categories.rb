# En Cash Flow tenemos los gastos del mes. Cada gasto pertenece a una Categoría (hija).
# Esta categoría hija pertenece a una Categoría (padre). Los gastos solo se asocian con categorías hijas.
#
# ¿Qué cambiaría al normalizar las categorías hijas de padres?
#
# ¿Qué cambiaría para las consultas de gastos del mes?
#
# ¿Qué cambiaría para los gastos del mes por categoría selecta?
#

class Category
  self.table_name = "parent_categories"

  has_many :subcategories
  has_many :expenditures, through: :subcategories

  def self.month_expenditure_for(category_name, user)
    time_range = Date.current.beginning_of_month..Date.current.end_of_month

    children = Category.find_by(name: category_name).subcategories

    children.each_with_object({}) do |child, obj|
      obj[child.name.to_sym] = child.expenditures.where(spent_at: time_range, user: user).sum(:amount)
    end
    # [
    #   {
    #     gasolina: 100_000
    #   }
    # ]

    # Current version
    #
    # children = Category.find_by(name: category_name).child_categories
    # children.each_with_object({}) do |child, obj|
    #   obj[child.name.to_sym] = child.expenditures.where(spent_at: time_range, user: user).sum(:amount)
    # end
  end

  def current_month_total_for(user)
    time_range = Date.current.beginning_of_month..Date.current.end_of_month

    expenditures.where(spent_at: time_range, user: user).sum(:amount)
  end

  # Table name: parent_categories
  #
  # color :string
  # decorable :boolean
end

class Subcategory
  self.table_name = "categories"

  belongs_to :category

  has_many :expenditures
end

class Expenditure
  belongs_to :subcategory
end
