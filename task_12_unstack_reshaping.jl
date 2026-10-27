# ==============================================================================
# Модуль 3. Объединение таблиц (Joins) и решейпинг (Reshaping)
# Задача 12 (Модуль 3, Задача 3): Формирование витрины показателей через unstack
#
# Условие задачи:
# 1. Задана витрина показателей metrics_long в длинном формате.
# 2. С помощью @chain и unstack перевести данные в широкий формат:
#    - строки: :pharmacy_id
#    - столбцы: :metric_name
#    - значения: :metric_val
# 3. Сохранить результат в metrics_wide и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

metrics_long = DataFrame(
    pharmacy_id = ["Apteka_1", "Apteka_1", "Apteka_2", "Apteka_2", "Apteka_3", "Apteka_3"],
    metric_name = ["Выручка", "Чеки", "Выручка", "Чеки", "Выручка", "Чеки"],
    metric_val = [450000.0, 1200.0, 310000.0, 890.0, 520000.0, 1450.0]
)

metrics_wide = @chain metrics_long begin
    unstack(
        :pharmacy_id,
        :metric_name,
        :metric_val
    )
end

println("Сводная витрина аптек (широкий формат):")
println(metrics_wide)
