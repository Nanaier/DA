import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.max_colwidth', None)
pd.set_option('display.width', 320)


def read_dataset(path):
    data = pd.read_csv(path, sep=";", encoding='cp1252')
    return data


def convert_column_to_float(dataset, column_label):
    dataset[column_label] = dataset[column_label].str.replace(',', '.').astype(float)


def convert_nan_to_mean(dataset):
    dataset.fillna(dataset.mean(), inplace=True)


def convert_float_to_positive(dataset, column_label):
    dataset[column_label] = dataset[column_label].abs()


def create_boxplots(dataset):
    grp, axes = plt.subplots(1, 4, figsize=(12, 6))
    grp.suptitle("Boxplots")
    axes[0].boxplot(dataset["Area"])
    axes[0].set_title("Area")

    axes[1].boxplot(dataset["Population"])
    axes[1].set_title("Population")

    axes[2].boxplot(dataset["CO2 emission"])
    axes[2].set_title("CO2 emission")

    axes[3].boxplot(dataset["GDP per capita"])
    axes[3].set_title("GDP per capita")
    plt.show()


def create_hists(dataset):
    grp, axes = plt.subplots(2, 2, figsize=(12, 7))
    grp.suptitle("Histograms")
    axes[0, 0].hist(dataset["Area"])
    axes[0, 0].set_title("Area")

    axes[0, 1].hist(dataset["Population"])
    axes[0, 1].set_title("Population")

    axes[1, 0].hist(dataset["CO2 emission"])
    axes[1, 0].set_title("CO2 emission")

    axes[1, 1].hist(dataset["GDP per capita"])
    axes[1, 1].set_title("GDP per capita")
    plt.show()


def country_max_gdp(dataset):
    country_id = dataset['GDP per capita'].idxmax()
    country_row = dataset.loc[country_id]
    country_name = country_row['Country Name']
    print("\n---------///----------\n")
    print("Name of the country with the max GDP per capita: ", country_name)
    print("The max GDP per capita: ", country_row['GDP per capita'])
    print("\n---------///----------\n")


def country_min_area(dataset):
    country_id = dataset['Area'].idxmin()
    country_row = dataset.loc[country_id]
    country_name = country_row['Country Name']
    print("\n---------///----------\n")
    print("Name of the country with the min Area: ", country_name)
    print("The min Area: ", country_row['Area'])
    print("\n---------///----------\n")


def max_avg_area_in_region(dataset):
    avg_area = dataset.groupby('Region').agg('mean')
    region_name = avg_area['Area'].idxmax()
    max_area = avg_area['Area'].max()
    print("\n---------///----------\n")
    print("Name of the Region with the max mean Area: ", region_name)
    print("The max mean Area: ", max_area)
    print("\n---------///----------\n")


def max_density_in_regions(dataset):
    max_density_id = dataset['Density'].idxmax()
    max_density_row = dataset.loc[max_density_id]
    max_density_name = max_density_row['Country Name']
    print("\n---------///----------\n")
    print("Name of the country with the max density in the world: ", max_density_name)
    print("The max density in the world: ", max_density_row['Density'])
    print("\n---------///----------\n")

    max_density_eur_asia_id = dataset['Density'].where(dataset['Region'] == 'Europe & Central Asia').idxmax()
    max_density_eur_asia_country_row = dataset.loc[max_density_eur_asia_id]
    max_density_eur_asia_country_name = max_density_eur_asia_country_row['Country Name']
    print("\n---------///----------\n")
    print("Name of the country with the max density in Europe & Central Asia: ", max_density_eur_asia_country_name)
    print("The max density in Europe & Central Asia: ", max_density_eur_asia_country_row['Density'])
    print("\n---------///----------\n")


def median_mean_region_equal(dataset):
    regions_average_gdp = dataset.groupby(['Region']).mean()['GDP per capita']
    regions_mediana_gdp = dataset.groupby(['Region']).median()['GDP per capita']
    regins_coincide = pd.merge(regions_average_gdp, regions_mediana_gdp, how='inner')
    print('\nAverage gdp in region: ', regions_average_gdp)
    print('\nMedian gdp in region: ', regions_mediana_gdp)
    print('\nRegions when coincide average and median gdp: \n', regins_coincide)


def top_least_5_gdp(dataset):
    dataset['GDP'] = dataset['GDP per capita'] * dataset['Population']
    print("\n---------///----------\n")
    print("Top 5 countries by GDP:\n")
    print(dataset.sort_values(by=['GDP'], ascending=False).head(5))
    print("Last 5 countries by GDP:\n")
    print(dataset.sort_values(by=['GDP'], ascending=True).head(5))
    print("\n---------///----------\n")


def top_least_5_co2_per_capita(dataset):
    dataset['CO2 per capita'] = dataset['CO2 emission'] / dataset['Population']
    print("\n---------///----------\n")
    print("Top 5 countries by CO2 per capita:\n")
    print(dataset.sort_values(by=['CO2 per capita'], ascending=False).head(5))
    print("Last 5 countries by CO2 per capita:\n")
    print(dataset.sort_values(by=['CO2 per capita'], ascending=True).head(5))
    print("\n---------///----------\n")


if __name__ == "__main__":
    data_path = 'data/Data2.csv'
    dataset = read_dataset(data_path)

    print(dataset.head(10))

    convert_column_to_float(dataset, "Area")
    convert_column_to_float(dataset, "GDP per capita")
    convert_column_to_float(dataset, "CO2 emission")


    convert_nan_to_mean(dataset)
    convert_float_to_positive(dataset, "GDP per capita")
    convert_float_to_positive(dataset, "Area")

    dataset['Density'] = dataset['Population'] / dataset['Area']
    print(dataset.head(10))

    create_boxplots(dataset)
    create_hists(dataset)

    country_max_gdp(dataset)
    country_min_area(dataset)

    max_avg_area_in_region(dataset)
    max_density_in_regions(dataset)


    median_mean_region_equal(dataset)

    top_least_5_gdp(dataset)
    top_least_5_co2_per_capita(dataset)
