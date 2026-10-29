# ==============================================================================
# Модуль 6. Скользящие окна (Rolling / Moving Averages) и сглаживание рядов
# Задача 21 (Модуль 6, Задача 3): Экспоненциальное сглаживание (EMA) и детекция выбросов
#
# Условие задачи:
# 1. Задан датафрейм pharma_orders с отгрузками препаратов.
# 2. Написать функцию calc_ema(values, alpha) для рекуррентного расчета EMA.
# 3. Через @chain:
#    - Рассчитать экспоненциальный тренд ema_sales (alpha = 0.4).
#    - Рассчитать модуль отклонения abs_dev (abs(units - ema_sales)).
#    - Поставить булев флаг аномалии is_anomaly (abs_dev > 40.0).
# 4. Сохранить результат в orders_analyzed и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates

function calc_ema(values::AbstractVector{Float64}, alpha::Float64=0.5)
    n = length(values)
    ema = similar(values)
    ema[1] = values[1]
    for i in 2:n
        ema[i] = alpha * values[i] + (1 - alpha) * ema[i-1]
    end
    return ema
end

pharma_orders = DataFrame(
    order_date = [
        Date(2024, 3, 1), Date(2024, 3, 2), Date(2024, 3, 3), Date(2024, 3, 4),
        Date(2024, 3, 5), Date(2024, 3, 6), Date(2024, 3, 7), Date(2024, 3, 8)
    ],
    units = [100.0, 105.0, 102.0, 195.0, 110.0, 108.0, 60.0, 112.0]
)

orders_analyzed = @chain pharma_orders begin
    sort(:order_date)
    transform(:units => (u -> round.(calc_ema(u, 0.4), digits = 1)) => :ema_sales)
    transform([:units, :ema_sales] => ByRow((u, e) -> round(abs(u - e), digits=1)) => :abs_dev)
    transform(:abs_dev => ByRow(a -> a > 40.0) => :is_anomaly)
end

println("Анализ спроса через EMA и детектор аномалий:")
println(orders_analyzed)
