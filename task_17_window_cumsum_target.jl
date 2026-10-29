# ==============================================================================
# Модуль 5. Оконные функции, сдвиги и скользящие агрегации
# Задача 17 (Модуль 5, Задача 2): Нарастающий итог (cumsum) и выполнение плана
#
# Условие задачи:
# 1. Задан датафрейм network_sales с помесячными продажами аптечных сетей.
# 2. Через @chain:
#    - Отсортировать строки по аптечной сети и дате.
#    - Сгруппировать по pharmacy_chain.
#    - Рассчитать ytd_sales через кумулятивную сумму (cumsum).
#    - Рассчитать pct_target относительно target_plan (3_000_000.0).
# 3. Сохранить результат в cum_sales и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates

network_sales = DataFrame(
    pharmacy_chain = ["36.6", "36.6", "36.6", "Ригла", "Ригла", "Ригла"],
    month_date = [Date(2024, 3, 1), Date(2024, 1, 1), Date(2024, 2, 1), Date(2024, 2, 1), Date(2024, 3, 1), Date(2024, 1, 1)],
    sales = [1200000.0, 800000.0, 950000.0, 1100000.0, 1300000.0, 900000.0]
)

target_plan = 3000000.0

cum_sales = @chain network_sales begin
    sort([:pharmacy_chain, :month_date])
    groupby(:pharmacy_chain)
    transform(:sales => cumsum => :ytd_sales)
    transform(:ytd_sales => ByRow(s -> (s / target_plan) * 100) => :pct_target)
end

println("Продажи нарастающим итогом и выполнение плана:")
println(cum_sales)
