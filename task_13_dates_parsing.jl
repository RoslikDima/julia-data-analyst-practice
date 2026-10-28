# ==============================================================================
# Модуль 4. Работа с датами, временем и строками (Dates.jl & Strings)
# Задача 13 (Модуль 4, Задача 1): Парсинг дат и расчет календарных признаков
#
# Условие задачи:
# 1. Задан реестр отгрузок shipments со строковыми датами raw_date формата dd.mm.yyyy.
# 2. Через @chain и transform преобразовать raw_date в тип Date (shipment_date).
# 3. Извлечь month_num (номер месяца) и quarter_num (номер квартала).
# 4. Сохранить результат в enriched_shipments и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates

shipments = DataFrame(
    shipment_id = ["SH-001", "SH-002", "SH-003", "SH-004"],
    raw_date = ["12.01.2024", "25.04.2024", "08.08.2024", "19.11.2024"],
    amount = [150000.0, 230000.0, 95000.0, 410000.0]
)

enriched_shipments = @chain shipments begin
    transform(:raw_date => ByRow(s -> Date(s, dateformat"dd.mm.yyyy")) => :shipment_date)
    transform(
        :shipment_date => ByRow(month) => :month_num,
        :shipment_date => ByRow(quarterofyear) => :quarter_num
    )
end

println("Витрина отгрузок с календарными признаками:")
println(enriched_shipments)
