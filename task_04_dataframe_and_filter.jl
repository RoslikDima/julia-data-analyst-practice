# ==============================================================================
# Модуль 2. DataFrames.jl и цепочки вычислений (@chain)
# Задача 4 (Модуль 2, Задача 1): Создание DataFrame и первая фильтрация
#
# Условие задачи:
# 1. Подключить DataFrames и Chain.
# 2. Создать DataFrame pharma_df с колонками product, price, in_stock.
# 3. Через макрос @chain отфильтровать таблицу, оставив только позиции,
#    которые есть в наличии (in_stock == true), и сохранить в available_df.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

pharma_df = DataFrame(
    product = ["Аспирин", "Ибупрофен", "Парацетамол", "Витамин C", "Амоксициллин"],
    price = [150.0, 280.0, 90.0, 420.0, 610.0],
    in_stock = [true, true, false, true, true]
)

available_df = @chain pharma_df begin
    filter(:in_stock => identity, _)
end

println("Доступные медикаменты:")
println(available_df)
