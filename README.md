# amr-motifs: Detección y Cuantificación de Motivos de Resistencia Antimicrobiana en R

![R](https://img.shields.io/badge/R-%3E%3D%204.0.0-blue.svg)
![Bioconductor](https://img.shields.io/badge/Bioconductor-Biostrings-green.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

Pipeline en R para la identificación, búsqueda bidireccional y cuantificación de motivos de secuencia conservados asociados a genes de resistencia antimicrobiana (*AMR*), enfocado en la familia de genes de beta-lactamasas (ej. *ampC*, *bla*).

---

## Tabla de Contenidos

- [Propósito del Proyecto](#-propósito-del-Proyecto)
- [Objetivos de Aprendizaje](#-objetivos-de-aprendizaje)
- [Estructura del Repositorio](#-estructura-del-repositorio)
- [Requisitos y Dependencias](#-requisitos-y-dependencias)
- [Clonar el Repositorio](#-clonar-el-repositorio)
- [Instrucciones de Uso](#-instrucciones-de-uso)
- [Licencia](#-licencia)

---

## Propósito del Proyecto

El objetivo biológico de este repositorio es analizar secuencias de DNA en formato FASTA correspondientes a variantes del gen de resistencia a beta-lactámicos (*ampC*). A través del paquete `Biostrings` de Bioconductor, el script permite:

1. Cargar conjuntos de datos multi-FASTA.
2. Definir patrones o motivos oligonucleotídicos de interés.
3. Realizar búsquedas en ambas hebras (directa y reverso complementaria).
4. Exportar un informe cuantitativo tabulado en formato `.csv` con la longitud de las secuencias y la frecuencia de coincidencias.

---

## Objetivos de Aprendizaje

Al interactuar con este repositorio y ejecutar el script principal, los usuarios serán capaces de:

- **Procesamiento de Archivos Genómicos:** Importar y manipular secuencias de DNA múltiples en R utilizando las clases y estructuras especializadas del paquete `Biostrings`.
- **Reconocimiento de Patrones (Pattern Matching):** Definir, localizar y cuantificar motivos oligonucleotídicos específicos asociados a genes de resistencia antimicrobiana.
- **Análisis Bidireccional de DNA:** Comprender e implementar la lógica de búsqueda computacional evaluando tanto la hebra directa como la hebra reverso complementaria.
- **Gestión de Datos y Reportería:** Extraer métricas biológicas (como la longitud total y el conteo de motivos por secuencia) y consolidarlas en *dataframes* exportables a formatos estandarizados (`.csv`).
- **Reproducibilidad Computacional:** Navegar y utilizar una estructura de directorios convencional (`data/`, `scripts/`, `results/`) diseñada para mantener el orden y la reproducibilidad en proyectos de biología computacional.

---

## Estructura del Proyecto

El proyecto mantiene una estructura estandarizada para garantizar la reproducibilidad:

```text
amr-motifs/
├── data/
│   └── secuencias_ampC.fa       # Archivo FASTA con secuencias de entrada
├── scripts/
│   └── busqueda_motivos.R       # Script principal de procesamiento en R
├── results/
│   └── reporte_de_resistencia.csv # Archivo CSV generado con las coincidencias
├── .gitignore                   # Archivos y carpetas excluidos de Git
├── LICENSE                      # Licencia MIT del proyecto
└── README.md                    # Documentación principal del repositorio
```
---

## Requisitos y Dependencias
Para ejecutar el código se requiere tener instalado R (v4.0 o superior) y la libreria **Biostrings**:

```{r}
# Instalación del paquete Biostrings desde Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("Biostrings")
```
---
# Instrucciones de uso

### 1. Clonar el Repositorio
Para obtener una copia local de este proyecto en tu computadora, ejecuta los siguientes comandos en la terminal:

```bash
git clone https://github.com/Mike-EA/amr-motifs.git
cd amr-motifs
```

Si prefieres usar un repositorio específico, reemplaza `tu-usuario` por tu nombre de usuario o la organización correspondiente.

### 2. Interpretación de Resultados
El script genera un archivo `results/reporte_de_resistencia.csv` con una fila por cada secuencia de entrada y las siguientes columnas:

- `Secuencia`: el nombre de la secuencia tal como aparece en el archivo FASTA.
- `Longitud_bp`: la longitud de la secuencia en pares de bases.
- `Coincidencias_Hebra_Directa`: número de veces que el motivo definido aparece en la hebra directa.
- `Coincidencias_Hebra_Reversa`: número de veces que aparece el motivo reverso complementario en la hebra inversa.
- `Total_Motivos`: suma de coincidencias en ambas hebras.

### Cómo interpretar cada columna
- Un valor `0` en `Coincidencias_Hebra_Directa` o `Coincidencias_Hebra_Reversa` indica que el motivo no se encontró en esa hebra.
- Un valor mayor que `0` en cualquiera de las columnas de coincidencias sugiere la presencia de un motivo conservado asociado a genes de resistencia beta-lactamasa.
- `Total_Motivos` permite comparar la carga de motivos entre secuencias y detectar aquellas con mayor densidad de patrones compatibles con AMR.

### Relevancia biológica
- Las coincidencias en la hebra directa y en la hebra reversa complementaria ayudan a evaluar si el motivo está presente en cualquiera de las dos orientaciones de la molécula de ADN.
- Un mayor número de motivos conservados puede indicar una mayor probabilidad de que la secuencia pertenezca a una variante de un gen de resistencia bien conservado.
- Es importante combinar estos resultados con análisis adicionales (alineamientos, anotaciones genéticas y evidencia fenotípica) antes de concluir sobre resistencia antimicrobiana.

### 3. Personalización del Script en RStudio
1. Abre el proyecto en RStudio abriendo el archivo del script uibicado en `scripts/amr_motifs_script.R`.
2. Edita las variables de configuración al inicio del script según los requerimientos de tu análisis:
```{r}
# Parámetros editables del análisis
archivo_fasta   <- "data/mis_secuencias.fa"   # Ruta a tu archivo FASTA
motivo_secuencia <- "AAAACGGG"                 # Motivo oligonucleotídico a buscar

```
### 4. Ejecución del análisis y Generación de Reportes
Puedes correr el análisis de dos formas:
- **Desde RStudio:** selecciona todo el código en `scripts/amr_motifs_script.R` y presiona `Ctrl + Enter`, o `Cmd + Enter`en macOS.
- **Desde la línea de comandos/terminal**:
```{bash}
 Rscript scripts/busqueda_motivos.R
```

### 5. Interpretación de Resultados
Una vez completada la ejecución, se generará de forma automática el archivo de reporte en la ruta `results/reporte_de_resistencia.csv`.

La tabla resultante contendrá la siguiente estructura:

| Secuencia | Longitud_bp | Coincidencias_Hebra_Directa | Coincidencias_Hebra_Reversa | Total_Motivos |
| :--- | :---: | :---: | :---: | :---: |
| `gene_ampC_Ecoli_01` | 1146 | 0 | 0 | 0 |
| `gene_ampC_Kpneumoniae_02` | 1152 | 0 | 0 | 0 |
| `contig_ampC_Paeruginosa_03` | 65800 | 1 | 0 | 1 |

---

### Licencia
Este proyecto se distribuye bajo la Licencia MIT, lo que permite su uso, modificación y distribución con fines académicos y comerciales. Para más información, consulta el archivo LICENSE en la raíz del repositorio.
