# ==============================================================================
# Модуль 3. Объединение таблиц (Joins) и решейпинг (Reshaping)
# Задача 11 (Модуль 3, Задача 2): Нормализация данных через stack
#
# Условие задачи:
# 1. Задана широкая таблица quarterly_sales.
# 2. Через @chain и stack перевести данные в длинный формат:
#    - схлопнуть [:q1_sales, :q2_sales, :q3_sales]
#    - зафиксировать :product
#    - variable_name = :quarter
#    - value_name = :sales_amount
# 3. Сохранить в tidy_sales и вывести результат.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

quarterly_sales = DataFrame(
    product = ["Кардиомагнил", "Мексидол", "Афобазол"],
    q1_sales = [12000.0, 8500.0, 9300.0],
    q2_sales = [14500.0, 9100.0, 10200.0],
    q3_sales = [13800.0, 8900.0, 11000.0]
)

tidy_sales = @chain quarterly_sales begin
    stack(
        [:q1_sales, :q2_sales, :q3_sales], 
        :product, 
        variable_name = :quarter, 
        value_name = :sales_amount
    )
end

println("Нормализованный отчет (длинный формат):")
println(tidy_sales)
