# ==============================================================================
# Модуль 7. Аналитическая фильтрация данных (subset, filter) и срезы
# Задача 22 (Модуль 7, Задача 1): Многокритериальная фильтрация через subset
#
# Условие задачи:
# 1. Задан датафрейм pharma_contracts со списком контрактов.
# 2. Через @chain и subset:
#    - Отфильтровать amount >= 1_500_000.0 с параметром skipmissing = true.
#    - Отфильтровать is_active == true.
#    - Отсортировать строки по убыванию amount (rev = true).
# 3. Сохранить результат в audit_contracts и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates

pharma_contracts = DataFrame(
    contract_id = ["CNT-101", "CNT-102", "CNT-103", "CNT-104", "CNT-105", "CNT-106"],
    client = ["Аптека Вита", "Планета Здоровья", "Фармленд", "Ригла", "36.6", "Апрель"],
    amount = [1450000.0, 890000.0, 3200000.0, missing, 2100000.0, 1750000.0],
    is_active = [true, false, true, true, false, true],
    created_at = [
        Date(2024, 1, 10), Date(2024, 1, 15), Date(2024, 2, 1), 
        Date(2024, 2, 5), Date(2024, 2, 20), Date(2024, 3, 1)
    ]
)

audit_contracts = @chain pharma_contracts begin
    subset(
        :amount => ByRow(a -> a >= 1_500_000.0),
        :is_active => ByRow(i -> i == true);
        skipmissing = true
    )
    sort(:amount, rev = true)
end

println("Контракты для финансового аудита:")
println(audit_contracts)
