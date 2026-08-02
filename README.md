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
│   └── amr_motifs_script.R       # Script principal de procesamiento en R
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

### 2. Preparación de Datos de Entrada
Para ejecutar el análisis con tus propias secuencias o variantes génicas, debes preparar la información dentro de la carpeta `data/`:

1. **Obtención de secuencias (FASTA):**
    - Descarga las secuencias nucleotídicas de los genes de interés (ej. ***blaTEM, blaSHV, blaCTX-M, ampC***) desde bases de datos biológicas oficiales como NCBI [GeneBank](https://www.ncbi.nlm.nih.gov/genbank/), [CARD](https://card.mcmaster.ca/) o NCBI [ReferenceGeneCatalog](https://www.ncbi.nlm.nih.gov/pathogens/refgene/).
    - Guarda el archivo en formato `.fa` o `.fasta` dentro del directorio `data/`, por ejemplo, `data/mis_secuencias.fa`.
2. **Identificación de motivos conservados:**
    - Consulta la literatura ciantífica o bases de datos de dominio proteico para identificar motivos oligonucleotídicos conservados en regiones catalíticas de interés, por ejemplo, cajas promotoras, sitios de unión a represores AmpR, o tríadas catalíticas conservadas.

### 3. Personalización del Script en RStudio
1. Abre el proyecto en RStudio abriendo el archivo del script uibicado en `scripts/amr_motifs_script.R`.
2. Edita las variables de configuración al inicio del script según los requerimientos de tu análisis:
```{r}
# Parámetros editables del análisis
archivo_fasta   <- "data/mis_secuencias.fa"   # Ruta a tu archivo FASTA
motivo_secuencia <- "AAAACGGG"                 # Motivo oligonucleotídico a buscar

```

**Parámetros avanzados editables**
  - ***Búsqueda bidireccional:*** puedes activar o desactivar la búsqueda en la hebra complementaria ajustando los objetos `motivo_fwd`y `motivo_rev`.
  - ***Flexibilidad de búsqueda:*** si estás utilizando códigos de nucleótidos degenerados de nomenclatura IUPAC, como `R`para A/G o `Y` para C/T, cambia el argumento a `fixed = FALSE` en la función `vmatchPattern()`, por defatul su configuracioón es `fixed = TRUE`.
  
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
