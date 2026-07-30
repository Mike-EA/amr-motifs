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
