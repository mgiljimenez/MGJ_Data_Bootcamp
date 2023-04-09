import streamlit as st
import pandas as pd
import numpy as np
import pydeck as pdk
import time


st.set_page_config(page_title="Sevici Online", page_icon="bike")

csv_import=pd.read_csv("sevicidist.csv")
df = pd.DataFrame(csv_import)

st.sidebar.title("Sevici Visualization app")
st.sidebar.image("img\home.jpg")
menu=st.sidebar.selectbox("Menu",["Datos","Visualización","Filtrado","Mapa 3D"])


if menu =="Datos":
    st.title("Datos")
    st.metric("Total de bicis",sum(df.iloc[:,5]), "+20")
    st.dataframe(df)

elif menu =="Visualización":
    st.title("Estaciones Sevici")
    st.map(df.iloc[:,1:3])

elif menu =="Filtrado":
    st.title("Buscar estación")
    tipo_filtro= st.sidebar.radio( "Seleccione opción de filtrado", ('Calle', 'Capacidad & Distrito'))
    if tipo_filtro=="Calle":
        calles_opciones= sorted(df["CALLE"].unique())
        calle_sel=st.sidebar.selectbox("Calle", calles_opciones)
        mascara1=df.CALLE==calle_sel
        lista_calles=st.write(df[mascara1])
        st.map(df[mascara1].iloc[:,1:3])



    elif tipo_filtro==("Capacidad & Distrito"):
        capacidad= st.sidebar.radio( "Capacidad", ('<20', '>=20'))
        distrito=st.sidebar.radio("Distritos", (1,2,3,4))
        if capacidad=='<20':
            capacidad_mascara=df.CAPACITY<20
        elif capacidad==">=20":
            capacidad_mascara=df.CAPACITY>=20
        distrito_mascara=df.Distrito==distrito
        filtrado1=df[capacidad_mascara]
        filtrado2=filtrado1[distrito_mascara]
        st.map(filtrado2.iloc[:,1:3])
        st.write(filtrado2)

elif menu =="Mapa 3D":
    st.title("Mapa 3D") 
    my_bar = st.progress(0, text=None)
    for percent_complete in range(100):
        time.sleep(0.005)
        my_bar.progress(percent_complete +1, text="Cargando datos")
    st.success('Cargado')
   
    
    st.pydeck_chart(pdk.Deck(
        map_style=None,
        initial_view_state=pdk.ViewState(
            latitude=37.4,
            longitude=-6,
            zoom=11,
            pitch=500, elevation_scale=400, elevation_range=[1,400]
        ),
        layers=[
            
        
            pdk.Layer(
                'ScatterplotLayer',
                data=df,
                get_position='[LON, LAT]',
                get_color='[200, 30, 0, 160]',
                get_radius=50,
            ),
        ],
    ))

