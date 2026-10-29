# ==============================================================================
# Модуль 7. Аналитическая фильтрация данных (subset, filter) и срезы
# Задача 23 (Модуль 7, Задача 2): Групповая агрегация и фильтрация (HAVING)
#
# Условие задачи:
# 1. Задан датафрейм distributor_orders с заказами дистрибьюторов.
# 2. Через @chain:
#    - Сгруппировать по client_name (groupby).
#    - Рассчитать total_turnover (sum) и orders_count (length) через combine.
#    - Отфильтровать через subset: total_turnover >= 5_000_000 и orders_count > 2.
#    - Отсортировать по убыванию total_turnover (rev = true).
# 3. Сохранить результат в key_clients и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

distributor_orders = DataFrame(
    client_name = [
        "Фарм-Альянс", "МедСнаб", "Фарм-Альянс", "ЗдравСервис", 
        "МедСнаб", "Фарм-Альянс", "ЗдравСервис", "Фарм-Альянс"
    ],
    order_id = [101, 102, 103, 104, 105, 106, 107, 108],
    order_sum = [
        2100000.0, 1800000.0, 1400000.0, 950000.0, 
        2300000.0, 1900000.0, 1200000.0, 1100000.0
    ]
)

key_clients = @chain distributor_orders begin 
    groupby(:client_name)
    combine(
        :order_sum => sum => :total_turnover,
        :client_name => length => :orders_count
    )
    subset(
        :total_turnover => ByRow(t -> t >= 5_000_000),
        :orders_count => ByRow(o -> o > 2)
    )
    sort(:total_turnover, rev = true)
end

println("Ключевые клиенты сети (HAVING-фильтр):")
println(key_clients)
