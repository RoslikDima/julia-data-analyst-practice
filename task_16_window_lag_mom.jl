# ==============================================================================
# Модуль 5. Оконные функции, сдвиги и скользящие агрегации
# Задача 16 (Модуль 5, Задача 1): Оконный сдвиг (lag) и расчет динамики MoM
#
# Условие задачи:
# 1. Задан датафрейм monthly_sales с помесячными продажами брендов.
# 2. Через @chain:
#    - Отсортировать данные по бренду и дате.
#    - Сгруппировать по бренду (groupby).
#    - Рассчитать продажи предыдущего месяца sales_prev через ShiftedArrays.lag.
#    - Рассчитать mom_diff (sales - sales_prev).
# 3. Сохранить результат в sales_dynamic и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates, ShiftedArrays

monthly_sales = DataFrame(
    brand = ["CardioNorm", "CardioNorm", "CardioNorm", "NeuroRelax", "NeuroRelax", "NeuroRelax"],
    report_date = [Date(2024, 3, 1), Date(2024, 1, 1), Date(2024, 2, 1), Date(2024, 2, 1), Date(2024, 3, 1), Date(2024, 1, 1)],
    sales = [1250000.0, 980000.0, 1100000.0, 840000.0, 910000.0, 800000.0]
)

sales_dynamic = @chain monthly_sales begin
    sort([:brand, :report_date])
    groupby(:brand)
    transform(:sales => ShiftedArrays.lag => :sales_prev)
    transform([:sales, :sales_prev] => ByRow((s, sl) -> s - sl) => :mom_diff)
end

println("Анализ динамики продаж MoM:")
println(sales_dynamic)
