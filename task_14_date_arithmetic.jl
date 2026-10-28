# ==============================================================================
# Модуль 4. Работа с датами, временем и строками (Dates.jl & Strings)
# Задача 14 (Модуль 4, Задача 2): Календарная арифметика и интервалы дат
#
# Условие задачи:
# 1. Задан датафрейм заказов orders с колонками order_date и delivery_date.
# 2. Через @chain и transform рассчитать:
#    - delivery_days: разница между delivery_date и order_date в виде целого числа (дней).
#    - payment_due_date: дата фактической доставки + 30 календарных дней (Day(30)).
# 3. Сохранить результат в orders_processed и вывести витрину.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates

orders = DataFrame(
    order_id = ["ORD-101", "ORD-102", "ORD-103", "ORD-104"],
    order_date = [Date(2024, 2, 1), Date(2024, 2, 5), Date(2024, 2, 10), Date(2024, 2, 12)],
    delivery_date = [Date(2024, 2, 6), Date(2024, 2, 15), Date(2024, 2, 13), Date(2024, 2, 22)]
)

orders_processed = @chain orders begin
    transform(
        [:delivery_date, :order_date] => ByRow((deliv, ord) -> Dates.value(deliv - ord)) => :delivery_days,
        :delivery_date => ByRow(d -> d + Day(30)) => :payment_due_date
    )
end

println("Обработанные заказы с расчетными датами:")
println(orders_processed)
