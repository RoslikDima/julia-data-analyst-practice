# ==============================================================================
# Модуль 6. Скользящие окна (Rolling / Moving Averages) и сглаживание рядов
# Задача 19 (Модуль 6, Задача 1): Векторный расчет 3-дневного скользящего среднего
#
# Условие задачи:
# 1. Задан датафрейм daily_demand с посуточными продажами.
# 2. Через @chain и ShiftedArrays.lag:
#    - Отсортировать данные по дате (report_date).
#    - Рассчитать 3-дневное скользящее среднее без ручных циклов:
#      (v .+ lag(v, 1) .+ lag(v, 2)) ./ 3
#    - Округлить результат до 1 знака (round.(..., digits=1)).
# 3. Сохранить результат в demand_smoothed и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates, ShiftedArrays
using ShiftedArrays: lag

daily_demand = DataFrame(
    report_date = [
        Date(2024, 1, 1), Date(2024, 1, 2), Date(2024, 1, 3), 
        Date(2024, 1, 4), Date(2024, 1, 5), Date(2024, 1, 6), 
        Date(2024, 1, 7)
    ],
    units_sold = [120, 150, 90, 210, 180, 80, 95]
)

demand_smoothed = @chain daily_demand begin 
    sort(:report_date)
    transform(:units_sold => (v -> round.((v .+ lag(v, 1) .+ lag(v, 2)) ./ 3, digits=1)) => :sales_ma3)
end

println("Сглаженный ряд спроса (MA 3 days):")
println(demand_smoothed)
