import streamlit as st
import requests
import json
import socket
import time
import pandas as pd
from catalog import cmd1, cmd2, cmd3, cmd4, cmd5, cmd6, cmd7, cmd8, cmd9, cmd10, cmd11, cmd12, cmd13, cmd14



def get_local_ip():
    try:
        hostname = socket.gethostname()
        local_ip = socket.gethostbyname(hostname)
        return local_ip
    except socket.error as e:
        return st.error(f"Error al obtener la IP local: {e}")

def check_caldera_api_status():
    try:
        response = requests.get(f'{BASE_API_URL}/api/v2/health', headers=HEADERS)
        if response.status_code == 200:
            return st.markdown(" Caldera API connected: :white_check_mark:")
        else:
            return st.markdown(" Caldera API not connected: :x:")
    except requests.exceptions.RequestException as e:
        st.markdown(" Caldera API not connected: :x:")
        st.error(f"Ocurrió un error al realizar la solicitud")
        return None

def get_caldera_operations():
    try:
        response = requests.get(f'{BASE_API_URL}/api/v2/operations', headers=HEADERS)
        if response.status_code == 200:
            data = response.json()
            return data
        else:
            return st.error(f"Ocurrió un error al realizar la solicitud")
    except requests.exceptions.RequestException as e:
        st.error(f"Ocurrió un error al realizar la solicitud")
        return None



# CONFIGURA ESTOS VALORES
IP_SERVER = '192.168.0.170'
PORT = 8888
BASE_API_URL = f'http://{IP_SERVER}:{PORT}'
API_KEY = 'veWffGRY2YSWQL4CHKAyLTTRKXQEanPd3d1rs2_XJ9A'  # Sustituye por tu API Key real
HEADERS = {'KEY': API_KEY}



def show_operations():
    data = get_caldera_operations()
    if data:
        operations = [(operation['name'], operation['id']) for operation in data]
        name_to_id = {name: id_ for name, id_ in operations}
        names = list(name_to_id.keys())
        option = st.selectbox(
            "Operaciones:",
            options=names, 
            placeholder="Selecciona una operación"
        )
        if option:
            st.session_state['operation_id'] = name_to_id[option]
            return name_to_id[option]
        else:
            return ""

def create_potential_link(paw_id, command):
    #selected_operation_id = show_operations()
    url = f'{BASE_API_URL}/api/v2/operations/{st.session_state["operation_id"]}/potential-links'
    data = {
        "paw": paw_id,
        "executor": {
            "name": 'psh',
            "command": command,
        },
        "ability": {
            "tactic": "discovery",
            "name": "pruebas desde app",
        }
    }
    response = requests.post(url, headers=HEADERS, data=json.dumps(data))
    if response.status_code == 200:
        st.success("Potential Link creado correctamente.")
    else:
        st.error("Error al crear Potential Link:", response.status_code, response.text)

def show_operation_summary():
    selected_operation_id = show_operations()
    if selected_operation_id:
        try:
            response = requests.get(f'{BASE_API_URL}/api/v2/operations/{selected_operation_id}', headers=HEADERS)
            if response.status_code == 200:
                data = response.json()
                st.write(data)
                st.markdown(f"### Información General\n\n- **Operación:** `{selected_operation_id}`\n- **Inicio:** `{data['start']}`\n- **Ofuscador:** `{data['obfuscator']}`\n- **Estado:** `{data['state']}`")
                rows = []
                for chain in data['chain']:
                    row = {
                        "PAW": chain['paw'],
                        "Comando": chain['command'][:30] + "...",
                        "Name": chain['ability']['name'],
                        "Táctica": chain['ability']['tactic'],
                        "Nombre Técnica": chain['ability']['technique_name'],
                        "ID Técnica": chain['ability']['technique_id']
                    }
                    rows.append(row)
                df = pd.DataFrame(rows)
                st.table(df)
                # Crear un formulario con un botón de envío
                with st.form("form_comando"):
                    paw_id = st.text_input("ID Agente")
                    comando = st.text_input("Escribe un comando para el agente")
                    enviar = st.form_submit_button("Enviar comando")
                    automatic = st.form_submit_button("Auto Ataque")
                # Procesar si se hizo submit
                if enviar:
                    st.write(f"Comando enviado: `{comando}`")
                    create_potential_link(paw_id, comando)
                if automatic:
                    create_potential_link_agentic(cmd1)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd2)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd3)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd4)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd5)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd6)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd7)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd8)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd9)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd10)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd11)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd12)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd13)
                    time.sleep(10) 
                    create_potential_link_agentic(cmd14)

            else:
                st.error(f"Ocurrió un error al realizar la solicitud")
        except requests.exceptions.RequestException as e:
            st.error(f"Ocurrió un error al realizar la solicitud")
            return None


def create_potential_link_agentic(data):
    url = f'{BASE_API_URL}/api/v2/operations/{st.session_state["operation_id"]}/potential-links'

    response = requests.post(url, headers=HEADERS, data=json.dumps(data))
    if response.status_code == 200:
        st.success("Automatizando ataque...")
    else:
        st.error("Error al crear Potential Link:", response.status_code, response.text)


#create_potential_link_agentic(data)    
check_caldera_api_status()
show_operation_summary()

