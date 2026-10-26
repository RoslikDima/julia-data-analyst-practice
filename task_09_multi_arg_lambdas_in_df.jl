# ==============================================================================
# Практика: Анонимные функции (лямбды)
# Задача 9 (Лямбды, Задача 3): Многоаргументные лямбды и тернарная логика в DataFrames
#
# Условие задачи:
# inventory_df = DataFrame(
#     batch_id = ["B-01", "B-02", "B-03", "B-04"],
#     days_to_expire = [15, 120, 25, 200],
#     stock_qty = [80, 500, 30, 150]
# )
# 1. Построить пайплайн @chain inventory_df begin ... end.
# 2. Через transform и ByRow с лямбдой двух аргументов рассчитать :status:
#    - days_to_expire < 30 && stock_qty > 50 -> "Срочная уценка"
#    - иначе -> "Норма"
# 3. Сохранить в evaluated_df и вывести результат.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

inventory_df = DataFrame(
    batch_id = ["B-01", "B-02", "B-03", "B-04"],
    days_to_expire = [15, 120, 25, 200],
    stock_qty = [80, 500, 30, 150]
)

evaluated_df = @chain inventory_df begin
    transform(
        [:days_to_expire, :stock_qty] => ByRow((d, s) -> d < 30 && s > 50 ? "Срочная уценка" : "Норма") => :status
    )
end

println("Оценка складских запасов:")
println(evaluated_df)
