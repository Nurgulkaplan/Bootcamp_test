
Your objective is to build a [Bubble Plot](https://en.wikipedia.org/wiki/Bubble_chart) that showcases the relationship between four key variables:

* Average Fare ($) Per City
* Total Number of Rides Per City
* Total Number of Drivers Per City
* City Type (Urban, Suburban, Rural)

In addition, you will be expected to produce the following three pie charts:

* % of Total Fares by City Type
* % of Total Rides by City Type
* % of Total Drivers by City Type

As final considerations:

* You must use the Pandas Library and the Jupyter Notebook.
* You must use the Matplotlib and Seaborn libraries.
* You must include a written description of three observable trends based on the data.
* You must use proper labeling of your plots, including aspects like: Plot Titles, Axes Labels, Legend Labels, Wedge Percentages, and Wedge Labels.
* Remember when making your plots to consider aesthetics!
  * You must stick to the Pyber color scheme (Gold, Light Sky Blue, and Light Coral) in producing your plot and pie charts.
  * When making your Bubble Plot, experiment with effects like `alpha`, `edgecolor`, and `linewidths`.
  * When making your Pie Chart, experiment with effects like `shadow`, `startangle`, and `explosion`.
* You must include an exported markdown version of your Notebook called  `README.md` in your GitHub repository.
* See [Example Solution](Pyber/Pyber_Example.pdf) for a reference on expected format.





```python
# Dependencies
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 
```


```python
csv_city_path = "city_data.csv"
reader_city = pd.read_csv(csv_city_path)
reader_city.head()

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city</th>
      <th>driver_count</th>
      <th>type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Melissaborough</td>
      <td>15</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Port Brianborough</td>
      <td>62</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>3</th>
      <td>New Katherine</td>
      <td>68</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Lake Charlesside</td>
      <td>65</td>
      <td>Urban</td>
    </tr>
  </tbody>
</table>
</div>




```python
csv_ride_path = "ride_data.csv"
reader_ride = pd.read_csv(csv_ride_path)
reader_ride.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city</th>
      <th>date</th>
      <th>fare</th>
      <th>ride_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Karenfurt</td>
      <td>2017-01-01 19:03:03</td>
      <td>32.90</td>
      <td>3383346995405</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Melissaborough</td>
      <td>2017-01-01 08:55:58</td>
      <td>19.59</td>
      <td>2791839504576</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Port Sandraport</td>
      <td>2017-01-01 16:21:54</td>
      <td>31.04</td>
      <td>3341437383289</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Curtismouth</td>
      <td>2017-01-03 06:36:53</td>
      <td>15.12</td>
      <td>6557246300691</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Port Michael</td>
      <td>2017-01-03 09:56:52</td>
      <td>19.65</td>
      <td>9887635746234</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Merge two dataframes 
merge_table = pd.merge(reader_city, reader_ride, on="city")
merge_table.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city</th>
      <th>driver_count</th>
      <th>type</th>
      <th>date</th>
      <th>fare</th>
      <th>ride_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
      <td>2017-01-02 10:56:28</td>
      <td>12.40</td>
      <td>7963408790849</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
      <td>2017-01-02 04:28:03</td>
      <td>18.78</td>
      <td>2315208159060</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
      <td>2017-01-03 03:00:08</td>
      <td>30.10</td>
      <td>558639764959</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
      <td>2017-01-01 00:10:21</td>
      <td>7.76</td>
      <td>9113511454178</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
      <td>2017-01-02 05:22:44</td>
      <td>22.00</td>
      <td>4171010688543</td>
    </tr>
  </tbody>
</table>
</div>




```python
City_Type = ["Urban", "Suburban", "Rural"]

```


```python
Urban_city_df = merge_table[merge_table['type']=='Urban']
Urban_city_df = Urban_city_df.groupby("city")
Urban_city_df.head()

Suburban_city_df = merge_table[merge_table['type']=='Suburban']
Suburban_city_df = Suburban_city_df.groupby("city")
Suburban_city_df.head()

Rural_city_df = merge_table[merge_table['type']=='Rural']
Rural_city_df = Rural_city_df.groupby("city")
Rural_city_df
```




    <pandas.core.groupby.DataFrameGroupBy object at 0x1080deda0>




```python
# Average Fare ($) Per City
Urban_ave_fare = Urban_city_df['fare'].mean()
Suburban_ave_fare = Suburban_city_df['fare'].mean()
Rural_ave_fare = Rural_city_df['fare'].mean()


```


```python
# Total Number of Rides Per City

Urban_ride_count = Urban_city_df['ride_id'].count()
Suburban_ride_count = Suburban_city_df['ride_id'].count()
Rural_ride_count = Rural_city_df['ride_id'].count()



```


```python
# Total Number of Drivers Per City
Urban_driver_number = Urban_city_df['driver_count'].sum()
Suburban_driver_number = Suburban_city_df['driver_count'].sum()
Rural_driver_number = Rural_city_df['driver_count'].sum()



```


```python
fig = plt.figure(figsize=(8,6))
ax = fig.add_subplot(111)
plt.scatter(Urban_ride_count,Urban_ave_fare,s=(Urban_driver_number),label='Urban', marker="o", color='orange',edgecolor = 'black',alpha=0.7,linewidth=1.5)
plt.scatter(Suburban_ride_count,Suburban_ave_fare,s=(Suburban_driver_number), label='Suburban',marker="o",color='lightgreen',edgecolor = 'black',alpha=0.7,linewidth=1.5)
plt.scatter(Rural_ride_count,Rural_ave_fare,s=(Rural_driver_number), label='Rural',marker="o",color='yellow',edgecolor = 'black',alpha=0.7,linewidth=1.5)
plt.title("PyBer Ride Sharing Data")
plt.xlabel("Total Number of Rides")
plt.ylabel("Average Fee")
plt.xlim([0,40])
plt.ylim([0,50])
plt.legend(loc="best") 
plt.grid()

```


![png](output_10_0.png)



```python
# Merge two dataframes 
merge_table = pd.merge(reader_city, reader_ride, on="city")
merge_table.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city</th>
      <th>driver_count</th>
      <th>type</th>
      <th>date</th>
      <th>fare</th>
      <th>ride_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
      <td>2017-01-02 10:56:28</td>
      <td>12.40</td>
      <td>7963408790849</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
      <td>2017-01-02 04:28:03</td>
      <td>18.78</td>
      <td>2315208159060</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
      <td>2017-01-03 03:00:08</td>
      <td>30.10</td>
      <td>558639764959</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
      <td>2017-01-01 00:10:21</td>
      <td>7.76</td>
      <td>9113511454178</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Tammyburgh</td>
      <td>11</td>
      <td>Urban</td>
      <td>2017-01-02 05:22:44</td>
      <td>22.00</td>
      <td>4171010688543</td>
    </tr>
  </tbody>
</table>
</div>




```python
Merge_table_city_type = merge_table.groupby('type')
# % of Total Fares by City Type
Perc_total_fares = 100*(Merge_table_city_type['fare'].sum()/merge_table['fare'].sum())
Perc_total_fares

# % of Total Rides by City Type
Perc_total_rides = 100*(Merge_table_city_type['ride_id'].count()/merge_table['ride_id'].count())
Perc_total_rides

# % of Total Drivers by City Type
Perc_total_drivers = 100*(Merge_table_city_type['driver_count'].sum()/merge_table['driver_count'].sum())
Perc_total_drivers
```




    type
    Rural        0.940728
    Suburban    12.468204
    Urban       86.591067
    Name: driver_count, dtype: float64



Perc_total_drivers


```python
# Labels for the sections of our pie chart
labels = ["Rural", "Suburban", "Urban"]

# The values of each section of the pie chart
sizes = [Perc_total_drivers[0],Perc_total_drivers[1],Perc_total_drivers[2]]

# The colors of each section of the pie chart
colors = ['gold', 'lightskyblue','lightcoral']

# Tells matplotlib to seperate the "Python" section from the others
explode = (0, 0, 0.3)


plt.title("Total percentage of Drivers")
# Automatically finds the percentages of each part of the pie chart
plt.pie(sizes, explode=explode, labels=labels, colors=colors,
        autopct="%1.1f%%", shadow=True, startangle=140)
```




    ([<matplotlib.patches.Wedge at 0x116d58710>,
      <matplotlib.patches.Wedge at 0x116d6e0f0>,
      <matplotlib.patches.Wedge at 0x116d6ea90>],
     [Text(-0.863174,0.681858,'Rural'),
      Text(-1.06653,0.269291,'Suburban'),
      Text(1.34668,-0.382695,'Urban')],
     [Text(-0.470822,0.371922,'0.9%'),
      Text(-0.581743,0.146886,'12.5%'),
      Text(0.865722,-0.246018,'86.6%')])




![png](output_14_1.png)


Perc_total_Rides


```python
# Labels for the sections of our pie chart
labels = ["Rural", "Suburban", "Urban"]

# The values of each section of the pie chart
sizes = [Perc_total_rides[0],Perc_total_rides[1],Perc_total_rides[2]]

# The colors of each section of the pie chart
colors = ['gold', 'lightskyblue','lightcoral']
# Tells matplotlib to seperate the "Python" section from the others
explode = (0, 0, 0.3)

plt.title("Total percentage of Rides")

# Automatically finds the percentages of each part of the pie chart
plt.pie(sizes, explode=explode, labels=labels, colors=colors,
        autopct="%1.1f%%", shadow=True, startangle=140)
```




    ([<matplotlib.patches.Wedge at 0x116ea63c8>,
      <matplotlib.patches.Wedge at 0x116ea6d68>,
      <matplotlib.patches.Wedge at 0x116eb9748>],
     [Text(-0.947536,0.558727,'Rural'),
      Text(-0.986001,-0.48765,'Suburban'),
      Text(1.33995,0.405629,'Urban')],
     [Text(-0.516838,0.30476,'5.3%'),
      Text(-0.537819,-0.265991,'26.3%'),
      Text(0.861396,0.260762,'68.4%')])




![png](output_16_1.png)


Perc_total_fares


```python
# Labels for the sections of our pie chart
labels = ["Rural", "Suburban", "Urban"]

# The values of each section of the pie chart

sizes = [Perc_total_fares[0],Perc_total_fares[1],Perc_total_fares[2]]

# The colors of each section of the pie chart
colors = ['gold', 'lightskyblue','lightcoral']
# Tells matplotlib to seperate the "Python" section from the others
explode = (0, 0, 0.3)

plt.title("Total percentage of Fares")

# Automatically finds the percentages of each part of the pie chart
plt.pie(sizes, explode=explode, labels=labels, colors=colors,
        autopct="%1.1f%%", shadow=True, startangle=140)
```




    ([<matplotlib.patches.Wedge at 0x116479080>,
      <matplotlib.patches.Wedge at 0x116479a20>,
      <matplotlib.patches.Wedge at 0x116c7f400>],
     [Text(-0.972833,0.513417,'Rural'),
      Text(-0.868153,-0.675508,'Suburban'),
      Text(1.26141,0.607331,'Urban')],
     [Text(-0.530636,0.280045,'6.8%'),
      Text(-0.473538,-0.368459,'29.7%'),
      Text(0.810905,0.390427,'63.5%')])




![png](output_18_1.png)

