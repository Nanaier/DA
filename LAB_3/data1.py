import pandas as pd
import matplotlib.pyplot as plt


# Зчитування даних із .csv-файлу по заданому шляху.
def read_dataset(path):
    data = pd.read_csv('data/Data1.csv', sep=';')
    return data


# Виведення перших 5 рядків датасету.
def print_first_five_rows(dataset):
    print(dataset.head(5))


# Виведення останніх 6 рядків датасету.
def print_last_six_rows(dataset):
    print(dataset.tail(6))


# Видалення стовпчику із абревіатурами (ISO).
def remove_iso(dataset):
    return dataset.drop('ISO', axis=1)


# Конвертація рядкових значень атрибуту (стовпчика) за назвою у тип float.
def convert_column_to_float(dataset, column_label):
    dataset[column_label] = dataset[column_label] \
        .str.replace(',', '.') \
        .astype(float)


# Додавання стовпчика з повним GDP.
def add_total_gdp(dataset):
    dataset['Total GDP'] = dataset['Population'] * dataset['GDP per capita']


# Заміна пропущенних значень нулями.
def replace_blank_with_zeros(dataset):
    return dataset.replace(' ', 0)


# Побудова діаграми розмаху для GDP per capita.
def gdp_per_capita_boxplot(dataset):
    plt.figure()
    plt.title('Діаграма розмаху для GDP per capita')
    plt.boxplot(dataset['GDP per capita'])


# Побудова графіку залежності High-technology exports від GDP.
def plot_tech_exports_from_gdp_dependency(dataset):
    plt.figure()
    plt.title('Залежність High-technology exports від GDP per capita')
    plt.xlabel('GDP per capita')
    plt.ylabel('High-technology exports')
    plt.plot(
        dataset['GDP per capita'],
        dataset['High-technology exports'],
        '*'
    )


if __name__ == "__main__":
    data_path = 'data/Data1.csv'
    dataset = read_dataset(data_path)

    dataset = remove_iso(dataset)

    convert_column_to_float(dataset, 'Population')
    add_total_gdp(dataset)

    dataset = replace_blank_with_zeros(dataset)

    # Виведення summary.
    print(dataset.describe())

    gdp_per_capita_boxplot(dataset)

    convert_column_to_float(dataset, 'High-technology exports')
    plot_tech_exports_from_gdp_dependency(dataset)

    plt.show()
