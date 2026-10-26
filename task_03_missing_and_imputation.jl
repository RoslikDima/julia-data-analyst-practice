# ==============================================================================
# Модуль 1. Основы синтаксиса и векторизация
# Задача 3: Статистика и очистка пропусков missing
#
# Условие задачи:
# cr = [2.4, 3.1, missing, 2.9, missing, 3.5, 2.8]
# 1. Подключить using Statistics
# 2. Посчитать среднюю конверсию без учета missing в avg_cr (через mean и skipmissing)
# 3. Заполнить пропуски в cr_clean через ifelse.(ismissing.(cr), avg_cr, cr)
# ==============================================================================

# Авторское решение (Dima Roslik):
cr = [2.4, 3.1, missing, 2.9, missing, 3.5, 2.8]

using Statistics

avg_cr = mean(skipmissing(cr))
println("Средняя конверсия (avg_cr): ", avg_cr)

cr_clean = ifelse.(ismissing.(cr), avg_cr, cr)
println("Вектор после импутации (cr_clean): ", cr_clean)
