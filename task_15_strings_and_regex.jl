# ==============================================================================
# Модуль 4. Работа с датами, временем и строками (Dates.jl & Strings)
# Задача 15 (Модуль 4, Задача 3): Строковые функции и регулярные выражения (Regex)
#
# Условие задачи:
# 1. Задан датафрейм catalog с полями item_raw_code и product_title.
# 2. Через @chain и transform:
#    - clean_title: strip и uppercase для наименования препарата.
#    - sku_code: извлечение цифр из составного кода через match(r"-(\d+)-", ...).
#    - country: извлечение кода страны через регулярное выражение.
# 3. Сохранить результат в catalog_clean и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

catalog = DataFrame(
    item_raw_code = ["MED-1024-RU", "VITA-8812-BY", "MED-3341-KZ", "VITA-0091-RU"],
    product_title = ["  парацетамол 500мг  ", "витамин с ", "  ибупрофен 200мг", " омега 3 форте  "]
)

catalog_clean = @chain catalog begin
    transform(
        :product_title => ByRow(p -> uppercase(strip(p))) => :clean_title,
        :item_raw_code => ByRow(s -> match(r"-(\d+)-", s).captures[1]) => :sku_code,
        :item_raw_code => ByRow(s -> match(r"-([A-Z]{2})$", s).captures[1]) => :country
    )
end

println("Очищенный справочник номенклатуры:")
println(catalog_clean)
