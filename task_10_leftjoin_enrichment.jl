# ==============================================================================
# Модуль 3. Объединение таблиц (Joins) и решейпинг (Reshaping)
# Задача 10 (Модуль 3, Задача 1): Обогащение данных через leftjoin
#
# Условие задачи:
# 1. Заданы таблицы sales и directory.
# 2. Через @chain выполнить leftjoin по ключу :drug_id.
# 3. Сохранить в enriched_sales и вывести результат.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

sales = DataFrame(
    order_id = [101, 102, 103, 104],
    drug_id = ["D1", "D2", "D1", "D3"],
    qty = [10, 5, 20, 8]
)

directory = DataFrame(
    drug_id = ["D1", "D2", "D4"],
    drug_name = ["Аспирин", "Ибупрофен", "Парацетамол"],
    category = ["НПВП", "НПВП", "Анальгетик"]
)

enriched_sales = @chain sales begin
    leftjoin(directory, on = :drug_id)
end

println("Обогащенный реестр отгрузок:")
println(enriched_sales)
