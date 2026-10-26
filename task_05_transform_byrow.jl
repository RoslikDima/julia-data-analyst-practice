# ==============================================================================
# Модуль 2. DataFrames.jl и цепочки вычислений (@chain)
# Задача 5 (Модуль 2, Задача 2): Расчет выручки и маржи через transform и ByRow
#
# Условие задачи:
# sales_df = DataFrame(
#     drug = ["Омепразол", "Азитромицин", "Аторвастатин"],
#     unit_price = [120.0, 310.0, 450.0],
#     unit_cost = [80.0, 200.0, 290.0],
#     qty = [50, 20, 15]
# )
# 1. Используя @chain sales_df и transform(...)
#    - создать :revenue построчно: unit_price * qty (через ByRow)
#    - создать :margin построчно: (unit_price - unit_cost) * qty (через ByRow)
# 2. Сохранить в calculated_df и вывести результат.
# ==============================================================================

using DataFrames, Chain

sales_df = DataFrame(
    drug = ["Омепразол", "Азитромицин", "Аторвастатин"],
    unit_price = [120.0, 310.0, 450.0],
    unit_cost = [80.0, 200.0, 290.0],
    qty = [50, 20, 15]
)

calculated_df = @chain sales_df begin
    transform(
        [:unit_price, :qty] => ByRow((p, q) -> p * q) => :revenue,
        [:unit_price, :unit_cost, :qty] => ByRow((p, c, q) -> (p - c) * q) => :margin
    )
end

println("Таблица с расчетом выручки и маржи:")
println(calculated_df)
