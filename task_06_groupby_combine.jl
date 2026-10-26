# ==============================================================================
# Модуль 2. DataFrames.jl и цепочки вычислений (@chain)
# Задача 6 (Модуль 2, Задача 3): Группировка и расчет сводных метрик
#
# Условие задачи:
# orders_df = DataFrame(
#     branch = ["Север", "Юг", "Север", "Центр", "Юг", "Север"],
#     amount = [540.0, 310.0, 890.0, 1200.0, 450.0, 220.0]
# )
# 1. Подключить using Statistics.
# 2. Построить пайплайн @chain orders_df begin ... end:
#    - сгруппировать по филиалу (:branch) через groupby
#    - с помощью combine(...) рассчитать:
#        * общую сумму продаж: :amount => sum => :total_amount
#        * средний чек: :amount => mean => :avg_amount
# 3. Сохранить результат в branch_summary и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Statistics

orders_df = DataFrame(
    branch = ["Север", "Юг", "Север", "Центр", "Юг", "Север"],
    amount = [540.0, 310.0, 890.0, 1200.0, 450.0, 220.0]
)

branch_summary = @chain orders_df begin
    groupby(:branch)
    combine(
        :amount => sum => :total_amount,
        :amount => mean => :avg_amount
    )
end

println("Сводные метрики по филиалам:")
println(branch_summary)
